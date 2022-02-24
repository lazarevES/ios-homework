//
//  InfoViewController.swift
//  Navigation
//
//  Created by Егор Лазарев on 08.02.2022.
//

import UIKit

class InfoViewController: UIViewController {

    var text: String
    
    init(title: String) {
        text = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.darkGray
        
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = text
        textLabel.textAlignment = .center
        textLabel.textColor = .white
        textLabel.lineBreakMode = .byTruncatingMiddle
        textLabel.numberOfLines = 2
        textLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        view.addSubview(textLabel)
        
        let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.width/2-50, y: UIScreen.main.bounds.height/2-25, width: 100, height: 50))
        button.backgroundColor = UIColor.black
        button.setTitle("Like", for: .normal)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.accessibilityIgnoresInvertColors = true
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
    
        view.addSubview(button)
    
        textLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        textLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -60).isActive = true
        
        button.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 30).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    
    @objc func showAlert() {
        
        let alertController = UIAlertController(title: "Важный вопрос", message: "Нравится??", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Да", style: .default) { (action) -> Void in
            print("Лайкнул")
        }
        
        let noAction = UIAlertAction(title: "Нет", style: .default) { (action) -> Void in
            print("Ну и ок чо")
        }
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    

}
