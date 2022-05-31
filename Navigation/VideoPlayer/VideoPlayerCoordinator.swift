//
//  VideoPlayerCoordinator.swift
//  Navigation
//
//  Created by Егор Лазарев on 01.06.2022.
//

import Foundation
import UIKit

class VideoPlayerCoordinator: VCCoordinator {
    
    var navigationController: UINavigationController?
    
    func Start() throws -> UINavigationController? {
        let factory = RootFactory(state: .video)
        navigationController = factory.startModule(coordinator: self, data: nil)
        return navigationController
    }
}
