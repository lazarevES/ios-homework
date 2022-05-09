//
//  AppDelegate.swift
//  Navigation
//
//  Created by Егор Лазарев on 01.02.2022.
//

import UIKit

@main

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let rootCoordinator = UITabBarCoordinator()
        
        let tabBarController = rootCoordinator.startApp(authenticationData: nil)
         
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
}

