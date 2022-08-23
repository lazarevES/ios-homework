//
//  MapsCoordinator.swift
//  Navigation
//
//  Created by Егор Лазарев on 23.08.2022.
//

import Foundation
import UIKit

class MapsCoordinator: VCCoordinator {
    
    var navigationController: UINavigationController?
    
    func Start(dbCoordinator: DatabaseCoordinatable? = nil) throws -> UINavigationController? {
        let factory = RootFactory(state: .map)
        navigationController = factory.startModule(coordinator: self, data: nil)
        return navigationController
    }
}
