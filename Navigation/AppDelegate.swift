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
        
        let feedViewController = FeedViewController()
        feedViewController.view.backgroundColor = UIColor.white
        let feedNavigationController = UINavigationController(rootViewController: feedViewController)
        
        let profileViewController = ProfileViewController()
        profileViewController.view.backgroundColor = .lightGray
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        
        feedNavigationController.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(named: "Feed"), selectedImage: UIImage(named: "SelectedFeed"))
        feedNavigationController.navigationBar.titleTextAttributes = [ .foregroundColor: UIColor.black]
        feedNavigationController.navigationBar.barTintColor = UIColor.white
        feedNavigationController.navigationBar.standardAppearance = appearance;
        feedNavigationController.navigationBar.scrollEdgeAppearance = feedNavigationController.navigationBar.standardAppearance
       
        profileNavigationController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(named: "Profile"), selectedImage: UIImage(named: "SelectedProfile"))
        profileNavigationController.navigationBar.titleTextAttributes = [ .foregroundColor: UIColor.black]
        profileNavigationController.navigationBar.barTintColor = UIColor.white
        profileNavigationController.navigationBar.standardAppearance = appearance;
        profileNavigationController.navigationBar.scrollEdgeAppearance = profileNavigationController.navigationBar.standardAppearance
       
        tabBarController.viewControllers = [feedNavigationController, profileNavigationController]
        tabBarController.tabBar.isHidden = false
        
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
}

