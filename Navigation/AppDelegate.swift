//
//  AppDelegate.swift
//  Navigation
//
//  Created by Егор Лазарев on 01.02.2022.
//

import UIKit
import AVFoundation
import FirebaseCore

@main

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let rootCoordinator = UITabBarCoordinator()
        
        let tabBarController = rootCoordinator.startApp(authenticationData: nil)
         
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, mode: .moviePlayback)
        }
        catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
        
       // let appConfiguration = getRandomConfiguration()
        //NetworkService.URLSessionDataTask(appConfiguration)
        
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
        
        return true
    }
    
    private func getRandomConfiguration() -> AppConfiguration {
        let array: [AppConfiguration] = [.people, .planets, .starships]
        return array[Int.random(in: 1...2)]
    }
    

}

