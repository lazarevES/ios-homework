//
//  FavoriteCoordinate.swift
//  Navigation
//
//  Created by Егор Лазарев on 26.07.2022.
//

import Foundation
import UIKit

class FavoriteCoordinator: VCCoordinator {
    
    var navigationController: UINavigationController?
    
    func Start() throws -> UINavigationController? {
        let factory = RootFactory(state: .favorite)
        navigationController = factory.startModule(coordinator: self, data: nil)
        return navigationController
    }
    
    func showPost(_ post: FeedPost) {
        navigationController?.pushViewController(PostViewController(coordinator: self, post: post), animated: true)
    }
    
    func showInfo(_ title: String, people: [String]? = nil) {
        navigationController?.present(InfoViewController(title: title, residentUrl: people), animated: true)
    }
}
