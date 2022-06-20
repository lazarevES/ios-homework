//
//  AudioPlayerCoordinator.swift
//  Navigation
//
//  Created by Егор Лазарев on 31.05.2022.
//

import Foundation
import UIKit

class AudioPlayerCordinator: VCCoordinator {
    
    var navigationController: UINavigationController?
    
    func Start() throws -> UINavigationController? {
        let factory = RootFactory(state: .player)
        navigationController = factory.startModule(coordinator: self, data: nil)
        return navigationController
    }
}
