//
//  Checker.swift
//  Navigation
//
//  Created by Егор Лазарев on 30.06.2022.
//

import Foundation
import FirebaseAuth

class Checker {
    
    var callback: ((_ result: Bool, _ message: String) -> Void)?
    
    static let shared: Checker = {
       Checker()
    }()
        
    private init() {}
    
    public func checkUserData(checkLogin: String, checkPassword: String, callback: @escaping (_ result: Bool, _ message: String) -> Void) {
        
        self.callback = callback
        Auth.auth().signIn(withEmail: checkLogin, password: checkPassword) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if let error = error {
                if let callback = strongSelf.callback {
                    callback(false, error.localizedDescription)
                }
            } else {
                if let callback = strongSelf.callback {
                    callback(true, "")
                }
            }
        }
        
    }
    
    public func registerUserData(Login: String, Password: String, callback: @escaping (_ result: Bool, _ message: String) -> Void){
        
        self.callback = callback
        Auth.auth().createUser(withEmail: Login, password: Password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if let error = error {
                if let callback = strongSelf.callback {
                    callback(false, error.localizedDescription)
                }
            } else {
                if let callback = strongSelf.callback {
                    callback(true, "")
                }
            }
        }
    }
    
    
}
