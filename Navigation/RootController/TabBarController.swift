//
//  TabBarConroller.swift
//  Navigation
//
//  Created by Егор Лазарев on 08.05.2022.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    var coordinator: UITabBarCoordinator?
    var authenticationData: (userService: UserService, name: String)?
    var timer: Timer? = nil
    
    var activView: UITabBarCoordinator.action {
        didSet {
            switchApp()
        }
    }
    
    init(coordinator: UITabBarCoordinator, activView: UITabBarCoordinator.action, authenticationData: (userService: UserService, name: String)?) {
        
        self.coordinator = coordinator
        self.activView = activView
        self.authenticationData = authenticationData
        
        super.init(nibName: nil, bundle: nil)
        
        switch self.activView {
        case .autorization:
            
            let logInViewController = LogInViewController() {(authenticationData: (userService: UserService, name: String)) in
                self.authenticationData = authenticationData
                self.activView = .allApp
            }
            logInViewController.view.backgroundColor = .white
            
            let loginFactory = MyLoginFactory()
            logInViewController.delegate = loginFactory.creatLoginInspector()
            
            let loginNavigationController = UINavigationController(rootViewController: logInViewController)
            self.viewControllers = [loginNavigationController]
            
        case .allApp:
            do {
                let feedCoordinator = FeedCoordinator()
                let feedNavigationController = try feedCoordinator.Start()
                let profileCoordinator = ProfileCoordinator(data: authenticationData!)
                let profileNavigationController = try profileCoordinator.Start()
                let playerCoordinator = AudioPlayerCordinator()
                let playerNavigationController = try playerCoordinator.Start()
                let videoPlayerCoordinator = VideoPlayerCoordinator()
                let videoPlayerNavigationController = try videoPlayerCoordinator.Start()
                if let feedNavC = feedNavigationController, let profileNavC = profileNavigationController, let playerNavC = playerNavigationController, let videoNavC = videoPlayerNavigationController {
                    self.viewControllers = [feedNavC, profileNavC, playerNavC, videoNavC]
                }
            } catch {
                preconditionFailure("Критическая ошибка")
            }
            
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func switchApp() {
        switch self.activView {
        case .autorization:
            
            let logInViewController = LogInViewController() {(authenticationData: (userService: UserService, name: String)) in
                self.authenticationData = authenticationData
                self.activView = .allApp
            }
            logInViewController.view.backgroundColor = .white
            
            let loginFactory = MyLoginFactory()
            logInViewController.delegate = loginFactory.creatLoginInspector()
            
            let loginNavigationController = UINavigationController(rootViewController: logInViewController)
            self.viewControllers = [loginNavigationController]
            
        case .allApp:
            do {
                let feedCoordinator = FeedCoordinator()
                let feedNavigationController = try feedCoordinator.Start()
                let profileCoordinator = ProfileCoordinator(data: authenticationData!)
                let profileNavigationController = try profileCoordinator.Start()
                let playerCoordinator = AudioPlayerCordinator()
                let playerNavigationController = try playerCoordinator.Start()
                let videoPlayerCoordinator = VideoPlayerCoordinator()
                let videoPlayerNavigationController = try videoPlayerCoordinator.Start()
                if let feedNavC = feedNavigationController, let profileNavC = profileNavigationController, let playerNavC = playerNavigationController, let videoNavC = videoPlayerNavigationController {
                    self.viewControllers = [feedNavC, profileNavC, playerNavC, videoNavC]
                }
            } catch {
                fatalError()
            }
        }
    }
}
