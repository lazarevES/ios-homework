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
    
    func Start() -> UINavigationController? {
        let factory = RootFactory(state: .feed)
        navigationController = factory.startModule(coordinator: self, data: nil)
        return navigationController
    }
    
    func pushPost(post: Post_old) {
        let postViewController = PostViewController(coordinator: self, post: post)
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
    func showInfoPost(info: String) {
        let infoViewController = InfoViewController(title: info)
        navigationController!.present(infoViewController, animated: true, completion: nil)
    }
    
    func showSubscription() {
        let subscription = Subscription()
        navigationController?.present(subscription, animated: true)
    }
    
}
