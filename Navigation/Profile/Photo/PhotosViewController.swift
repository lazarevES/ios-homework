//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Егор Лазарев on 01.03.2022.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {

    let imagePublisherFacade = ImagePublisherFacade()
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.scrollDirection = .vertical
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.toAutoLayout()
		collectionView.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .darkGray)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    var contentPhotoData: [UIImage] = []
    var timerCount = 0.0
    var timer: Timer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
		title = "photoGalery".localized
        view.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .darkGray)
        view.addSubview(collectionView)
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifire)
        useConstraint()
        
		contentPhotoData = constPhotoArray
		
        /*
         .default - 31.93 сек
         .background - 150.13 сек
         .userInitiated - 35.14 сек
         .userInteractive - 30.01 сек
         .utility - 36.36 сек
         .
        */
    }
    
    @objc func updateTimer() {
        timerCount += 0.01
        if contentPhotoData.count > 0 {
            print("Потрачено \(self.timerCount) секунд")
            timer!.invalidate()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func useConstraint() {
        NSLayoutConstraint.activate([collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        contentPhotoData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifire, for: indexPath) as? PhotosCollectionViewCell
        else {
            preconditionFailure("Произошло какое то говно при открытии ленты новостей")
        }
        cell.setupImage(contentPhotoData[indexPath.item])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.frame.width - 40) / 3, height: (collectionView.frame.width - 40) / 3)
    }
    
}


