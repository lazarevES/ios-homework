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
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .white
        
        let logInViewController = LogInViewController()
        logInViewController.view.backgroundColor = .white
        
        let loginFactory = MyLoginFactory()
        logInViewController.delegate = loginFactory.creatLoginInspector()
        
        let loginNavigationController = UINavigationController(rootViewController: logInViewController)
        tabBarController.viewControllers = [loginNavigationController]
 
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
}

