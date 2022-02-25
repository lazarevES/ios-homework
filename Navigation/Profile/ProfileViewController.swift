//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Егор Лазарев on 08.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        title = "Профиль"
       
        let profileHeaderView = ProfileHeaderView()
        view.addSubview(profileHeaderView)
        
        profileHeaderView.setupView()
       
        let titleButton = UIButton()
        titleButton.translatesAutoresizingMaskIntoConstraints = false
        titleButton.backgroundColor = #colorLiteral(red: 0.05408742279, green: 0.4763534069, blue: 0.9996182323, alpha: 1)
        titleButton.setTitle("Установить новый заголовок", for: .normal)
        titleButton.setTitleColor(.white, for: .highlighted)
        titleButton.addTarget(self, action: #selector(setNewTitle), for: .touchUpInside)
        
        view.addSubview(titleButton)
        
        titleButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        titleButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        titleButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        titleButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    @objc func setNewTitle() {
        if title == "Профиль" {
            title = "Киря"
        } else {
            title = "Профиль"
        }
    }

}
