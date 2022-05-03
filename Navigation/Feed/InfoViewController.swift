//
//  InfoViewController.swift
//  Navigation
//
//  Created by Егор Лазарев on 08.02.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.textAlignment = .center
        label.textColor = .white
        label.lineBreakMode = .byTruncatingMiddle
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        return label
    }()
    
    lazy var button: CustomButton = {
        let button = CustomButton(vc: self,
                                  text: "Like",
                                  backgroundColor: UIColor.black,
                                  backgroundImage: nil,
                                  tag: nil,
                                  shadow: false,
                                  tapAction: showAlert)
        button.frame = CGRect(x: UIScreen.main.bounds.width/2-50, y: UIScreen.main.bounds.height/2-25, width: 100, height: 50)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.accessibilityIgnoresInvertColors = true

        
        return button
    }()
    
    let showAlert = {(vc: UIViewController, sender: CustomButton) in
        
        let alertController = UIAlertController(title: "Важный вопрос", message: "Нравится??", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Да", style: .default) { (action) -> Void in
            print("Лайкнул")
        }
        
        let noAction = UIAlertAction(title: "Нет", style: .default) { (action) -> Void in
            print("Ну и ок чо")
        }
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        vc.present(alertController, animated: true, completion: nil)
    }
    
    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        textLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.toAutoLayout()
        view.backgroundColor = UIColor.darkGray
        
        view.addSubviews(textLabel, button)
        useConstraint()
        
    }
    
    func useConstraint() {
        NSLayoutConstraint.activate([textLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Const.smallSize),
                                     textLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Const.smallSize),
                                     textLabel.heightAnchor.constraint(equalToConstant: 60),
                                     textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -60),
                                     button.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 30),
                                     button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     button.widthAnchor.constraint(equalToConstant: Const.bigSize)])
    }
        
}
