//
//  MapsViewController.swift
//  Navigation
//
//  Created by Егор Лазарев on 23.08.2022.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class MapsViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    var marks = [MKPointAnnotation]()
    var userCoordinate: CLLocationCoordinate2D?
    var route: MKRoute?
    
    lazy var mapView: MKMapView = {
       let mapView = MKMapView()
        mapView.toAutoLayout()
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.mapType = .hybrid
        mapView.showsUserLocation = true
        mapView.isUserInteractionEnabled = true
        return mapView
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.toAutoLayout()
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = .darkGray
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(deleteAnnotation), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
		title = "map".localized
        view.addSubviews(mapView, button)
        mapView.delegate = self
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotation(_:)))
        gestureRecognizer.minimumPressDuration = 1
        mapView.addGestureRecognizer(gestureRecognizer)
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        
        useConstraint()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        
    }
    
    func useConstraint() {
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            button.widthAnchor.constraint(equalToConstant: 20),
            button.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    @objc func addAnnotation(_ recognizer: UIGestureRecognizer) {
        let touchedAt = recognizer.location(in: self.mapView)
        let touchedAtCoordinate : CLLocationCoordinate2D = mapView.convert(touchedAt, toCoordinateFrom: self.mapView)
        
        let newPin = MKPointAnnotation()
        newPin.coordinate = touchedAtCoordinate
        mapView.addAnnotation(newPin)
        marks.append(newPin)
        button.isHidden = false
    }
    
    @objc func deleteAnnotation() {
        
        button.isHidden = true
        mapView.removeAnnotations(marks)
        marks.removeAll()
    }
}

extension MapsViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if  locationManager.authorizationStatus == .authorizedAlways ||
            locationManager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count == 0 {
            return
        }
        
        locationManager.stopUpdatingLocation()
        self.userCoordinate = locations.first!.coordinate
        mapView.setRegion(MKCoordinateRegion(center: locations.first!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
    }
}

extension MapsViewController: MKMapViewDelegate {
     
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        if userCoordinate == nil {
            return
        }
        
        if let route = self.route {
            self.mapView.removeOverlay(route.polyline)
        }
        
        let directionRequest = MKDirections.Request()
        let sourcePlacemark = MKPlacemark(coordinate: userCoordinate!, addressDictionary: nil)
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationPlacemark = MKPlacemark(coordinate: view.annotation!.coordinate, addressDictionary: nil)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .walking
        
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            self.route = response.routes[0]
            self.mapView.addOverlay((self.route!.polyline), level: MKOverlayLevel.aboveRoads)
            
            let rect = self.route!.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if let route = self.route {
            self.mapView.removeOverlay(route.polyline)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .red
        renderer.lineWidth = 2.0
        
        return renderer
    }
    
}


