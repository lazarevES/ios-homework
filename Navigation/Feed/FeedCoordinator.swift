//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Егор Лазарев on 08.05.2022.
//

import Foundation
import UIKit

class FeedCoordinator: VCCoordinator {
    
    var navigationController: UINavigationController?
    
    func Start(dbCoordinator: DatabaseCoordinatable?) throws -> UINavigationController? {
        let factory = RootFactory(state: .feed)
        navigationController = factory.startModule(coordinator: self, data: nil, dbCoordinator: dbCoordinator)
        return navigationController
    }
    
    func showPost(_ post: FeedPost) {
        navigationController?.pushViewController(PostViewController(coordinator: self, post: post), animated: true)
    }
    
    func showInfo(_ title: String, people: [String]? = nil) {
        navigationController?.present(InfoViewController(title: title, residentUrl: people), animated: true)
    }
}
