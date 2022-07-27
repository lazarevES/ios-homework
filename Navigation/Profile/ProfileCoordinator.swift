//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Егор Лазарев on 09.05.2022.
//

import Foundation
import UIKit

class ProfileCoordinator: VCCoordinator {
    
    var navigationController: UINavigationController?
    let userService: UserService?
    let name: String?
    let callback: () -> Void
    
    init(data:(userService: UserService, name: String), callback: @escaping () -> Void) {
        self.userService = data.userService
        self.name = data.name
        self.callback = callback
    }
    
    func Start() throws -> UINavigationController? {

        let factory = RootFactory(state: .profile)
        if let unRapUserService = userService, let unRapName = name {
            navigationController = factory.startModule(coordinator: self, data: (userService: unRapUserService, name: unRapName))
            return navigationController
        } else {
            throw AppError.badData
        }
    }
    
    func DissmisApp() {
        self.callback()
    }
    
    func showPost(_ post: FeedPost) {
        navigationController?.pushViewController(PostViewController(coordinator: self, post: post), animated: true)
    }
    
    func showInfo(_ title: String, people: [String]? = nil) {
        navigationController?.present(InfoViewController(title: title, residentUrl: people), animated: true)
    }
    
}
