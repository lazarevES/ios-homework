//
//  InfoViewController.swift
//  Navigation
//
//  Created by Егор Лазарев on 08.02.2022.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Информация"
        view.backgroundColor = UIColor.darkGray
        
        let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.width/2-50, y: UIScreen.main.bounds.height/2-25, width: 100, height: 50))
        button.backgroundColor = UIColor.black
        button.setTitle("Вывести собщение", for: .normal)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.accessibilityIgnoresInvertColors = true
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        button.autoresizingMask = .init(arrayLiteral: [.flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleRightMargin])

        self.view.addSubview(button)
        
    }
    
    @objc func showAlert() {
        
        let alertController = UIAlertController(title: "Важный вопрос", message: "Эта информация была для вас полезной?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Да", style: .default) { (action) -> Void in
            print("Очень полезная")
        }
        
        let noAction = UIAlertAction(title: "Нет", style: .default) { (action) -> Void in
            print("Херня какая то как и презентация к этой ДЗ")
        }
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    

}
