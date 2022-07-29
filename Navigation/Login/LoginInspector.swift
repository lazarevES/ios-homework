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
    func checkUserToDataBase(callback: @escaping (_ user: User)->Void)
}

class LoginInspector: LoginViewControllerDelegate  {
    
    var callback: ((Result<Bool, AppError>, _ message: String) -> Void)?
    var callbackDataBase: ((_ user: User)->Void)?
    let dataBaseCoordinator: RealmDatabaseCoordinatable = RealmCoordinator()
    
    func signIn(login: String, password: String, callback: @escaping ((Result<Bool, AppError>), _ message: String) -> Void) {
        self.callback = callback
        Checker.shared.checkUserData(checkLogin: login, checkPassword: password) { result, message in
            if result {
                self.saveUser(login: login, password: password)
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
                self.saveUser(login: login, password: password)
                self.succsesRegisterIn()
            } else {
                self.failedRegisterIn(message: message)
                
            }
        }
    }
    
    func checkUserToDataBase(callback: @escaping (_ user: User)->Void) {
        callbackDataBase = callback
        dataBaseCoordinator.fetch(User.self, predicate: nil) { result in
            switch result {
            case .success(let UserModels):
                if UserModels.count > 0 {
                    if let callbackDataBase = self.callbackDataBase, let _ = UserModels[0].name {
                        print(UserModels[0])
                        callbackDataBase(UserModels[0])
                    }
                }
            case .failure:
                break
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
    
    private func saveUser(login: String, password: String) {
        let user = User(name: login, password: password, status: "", avatarName: "")
        dataBaseCoordinator.create(User.self, keyedValues: [user.keyedValues])
    }
    
}
