//
//  LocalizableService.swift
//  Navigation
//
//  Created by Егор Лазарев on 04.09.2022.
//

import Foundation

class LocalizableService {
    
    enum Keys: String {
        case map = "maps"
        case found = "found"
        case clear = "clear"
        case favorites = "favorites"
        case foundAuthor = "foundAuthor"
        case foundAuthorText = "foundAuthorText"
        case agree = "agree"
        case delete = "delete"
        case emailOrPhone = "emailOrPhone"
        case password = "password"
        case enter = "enter"
        case registration = "registration"
        case feed = "feed"
        case profile = "profile"
        case music = "music"
        case photos = "photos"
        case photoGalery = "photoGalery"
        case exit = "exit"
        case userNotFound = "userNotFound"
        case setStatus = "setStatus"
        case info = "info"
        case like = "like"
        case views = "views"
    }
    
    static func getText(key: Keys, numeric: Int? = nil) -> String {
        
        var string = NSLocalizedString(key.rawValue, comment: "")
        
        if let numeric = numeric {
            string = String.localizedStringWithFormat(string, numeric)
        }
        return string
    }
 
}
