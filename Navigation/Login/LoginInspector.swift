//
//  LoginInspector.swift
//  Navigation
//
//  Created by Егор Лазарев on 30.06.2022.
//

import Foundation

protocol LoginViewControllerDelegate: AnyObject {
    func signIn(login: String, password: String, callback: @escaping (_ result: (Result<Bool, AppError>), _ message: String) -> Void)
    func registerIn(login: String, password: String, callback: @escaping (_ result: (Result<Bool, AppError>), _ message: String) -> Void)
}

class LoginInspector: LoginViewControllerDelegate  {
    
    var callback: ((Result<Bool, AppError>, _ message: String) -> Void)?
 
    func signIn(login: String, password: String, callback: @escaping ((Result<Bool, AppError>), _ message: String) -> Void) {
        self.callback = callback
        Checker.shared.checkUserData(checkLogin: login, checkPassword: password) { result, message in
            if result {
                self.succsesSignIn()
            } else {
                self.failedSignIn(message: message)
                
            }
        }
    }
    
    func registerIn(login: String, password: String, callback: @escaping ((Result<Bool, AppError>), _ message: String) -> Void) {
        self.callback = callback
        Checker.shared.registerUserData(Login: login, Password: password) { result, message in
            if result {
                self.succsesRegisterIn()
            } else {
                self.failedRegisterIn(message: message)
                
            }
        }
    }
    
    private func succsesSignIn() {
        if let callback = callback {
            callback(.success(true), "")
        }
    }
    
    private func succsesRegisterIn() {
        if let callback = callback {
            callback(.success(true), "")
        }
    }
    
    private func failedSignIn(message: String) {
        if let callback = callback {
            callback(.success(false), message)
        }
    }
    
    private func failedRegisterIn(message: String) {
        if let callback = callback {
            callback(.success(false), message)
        }
    }
    
}
