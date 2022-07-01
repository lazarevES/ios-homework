//
//  RootFactory.swift
//  Navigation
//
//  Created by Егор Лазарев on 08.05.2022.
//

import Foundation
import UIKit

final class RootFactory {
    
    enum State {
        case feed
        case profile
        case player
        case video
    }
    
    var state: State
    
    init(state: State) {
        self.state = state
    }
    
    func startModule(coordinator: VCCoordinator, data: (userService: UserService, name: String)?) -> UINavigationController? {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        
        switch state {
        case .feed:
            let viewModel = FeedModel(coordinator: coordinator as! FeedCoordinator)
            let feedViewController = FeedViewController(coordinator: coordinator as! FeedCoordinator, model: viewModel)
            feedViewController.view.backgroundColor = UIColor.white
            let feedNavigationController = UINavigationController(rootViewController: feedViewController)
            
            feedNavigationController.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(named: "Feed"), selectedImage: UIImage(named: "SelectedFeed"))
            feedNavigationController.navigationBar.titleTextAttributes = [ .foregroundColor: UIColor.black]
            feedNavigationController.navigationBar.barTintColor = UIColor.white
            feedNavigationController.navigationBar.standardAppearance = appearance;
            feedNavigationController.navigationBar.scrollEdgeAppearance = feedNavigationController.navigationBar.standardAppearance
            return feedNavigationController
            
        case .profile:
            
            if let userData = data {
                let profileViewController = ProfileViewController(coordinator: coordinator as! ProfileCoordinator, userService: userData.userService, name: userData.name)
                let profileNavigationController = UINavigationController(rootViewController: profileViewController)
                
                profileNavigationController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(named: "Profile"), selectedImage: UIImage(named: "SelectedProfile"))
                profileNavigationController.navigationBar.titleTextAttributes = [ .foregroundColor: UIColor.black]
                profileNavigationController.navigationBar.barTintColor = UIColor.white
                profileNavigationController.navigationBar.standardAppearance = appearance;
                profileNavigationController.navigationBar.scrollEdgeAppearance = profileNavigationController.navigationBar.standardAppearance
                
                return profileNavigationController
            }
            
        case .player:
            
            let playerViewController = AudioPlayer(coordinator: coordinator as! AudioPlayerCordinator)
            let playerNavigationController = UINavigationController(rootViewController: playerViewController)
            
            playerNavigationController.tabBarItem = UITabBarItem(title: "Музыка", image: UIImage(named: "music"), selectedImage: UIImage(named: "SelectedMusic"))
            playerNavigationController.navigationBar.titleTextAttributes = [ .foregroundColor: UIColor.black]
            playerNavigationController.navigationBar.barTintColor = UIColor.white
            playerNavigationController.navigationBar.standardAppearance = appearance;
            playerNavigationController.navigationBar.scrollEdgeAppearance = playerNavigationController.navigationBar.standardAppearance
            
            return playerNavigationController
            
        case .video:
            
            let videoPlayerViewController = VideoPlayer(coordinator: coordinator as! VideoPlayerCoordinator)
            let videoPlayerNavigationController = UINavigationController(rootViewController: videoPlayerViewController)
            
            videoPlayerNavigationController.tabBarItem = UITabBarItem(title: "Видео", image: UIImage(named: "music"), selectedImage: UIImage(named: "SelectedMusic"))
            videoPlayerNavigationController.navigationBar.titleTextAttributes = [ .foregroundColor: UIColor.black]
            videoPlayerNavigationController.navigationBar.barTintColor = UIColor.white
            videoPlayerNavigationController.navigationBar.standardAppearance = appearance;
            videoPlayerNavigationController.navigationBar.scrollEdgeAppearance = videoPlayerNavigationController.navigationBar.standardAppearance
            
            return videoPlayerNavigationController
        }
        
        return nil
        
    }
}
