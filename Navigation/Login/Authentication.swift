//
//  Authentication.swift
//  Navigation
//
//  Created by Егор Лазарев on 03.05.2022.
//

import Foundation

protocol LoginViewControllerDelegate: AnyObject {
    var counter: Int { get }
    func checkPassword(login: String, password: String) -> Bool
}

class LoginInspector: LoginViewControllerDelegate  {
    
    var counter: Int = 3
    
    func checkPassword(login: String, password: String) -> Bool {
        counter -= 1
       return Checker.shared.checkUserData(checkLogin: login.hash, checkPassword: password.hash)
    }
    
}

class Checker {
    
    static let shared: Checker = {
       Checker()
    }()
    
    private let login = "Киря".hash
    private let pswd = "123".hash
    
    private init() {}
    
    public func checkUserData(checkLogin: Int, checkPassword: Int) -> Bool {
        checkLogin == login && checkPassword == pswd
    }
    
}

protocol LoginFactory {
    func creatLoginInspector() -> LoginViewControllerDelegate
}

class MyLoginFactory: LoginFactory {
    func creatLoginInspector() -> LoginViewControllerDelegate {
        LoginInspector()
    }
}
