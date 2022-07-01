//
//  Authentication.swift
//  Navigation
//
//  Created by Егор Лазарев on 03.05.2022.
//

import Foundation

protocol LoginFactory {
    func creatLoginInspector() -> LoginViewControllerDelegate
}

class MyLoginFactory: LoginFactory {
    func creatLoginInspector() -> LoginViewControllerDelegate {
        LoginInspector()
    }
}
