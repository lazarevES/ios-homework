//
//  PostViewController.swift
//  Navigation
//
//  Created by Егор Лазарев on 08.02.2022.
//

import UIKit

class PostViewController: UIViewController {

    var post: FeedPost
    var coordinator: VCCoordinator
    let postView = PostView()
    
    init(coordinator: VCCoordinator, post: FeedPost) {
        self.post = post
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
		let infoBarButtonItem = UIBarButtonItem(title: "info".localized, style: .plain, target: self, action: #selector(showInfo))
        self.navigationItem.rightBarButtonItem  = infoBarButtonItem
      
        view.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .darkGray)
        
        title = post.title
        postView.setupPost(post: post)
        view.addSubview(postView)
       
        useConstraint()
        postView.postToFullScreen()
        
    }
    
    func useConstraint() {
        NSLayoutConstraint.activate([postView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     postView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                     postView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     postView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
                                    ])
    }
    
    @objc func showInfo() {
        if post.postType == .post {
            guard let coordinator = self.coordinator as? FeedCoordinator else {
                guard let coordinator = self.coordinator as? FavoriteCoordinator else {
                    let coordinator = self.coordinator as? ProfileCoordinator
                    coordinator?.showInfo(post.title)
                    return
                }
                coordinator.showInfo(post.title)
                return
            }
            coordinator.showInfo(post.title)
    } else {
        NetworkService.URLSessionDataTask(postInfo: post.description, type: post.postType) { title, people in
            DispatchQueue.main.async {
                guard let coordinator = self.coordinator as? FeedCoordinator else {
                    guard let coordinator = self.coordinator as? FavoriteCoordinator else {
                        let coordinator = self.coordinator as? ProfileCoordinator
                        coordinator?.showInfo(title, people: people)
                        return
                    }
                    coordinator.showInfo(title, people: people)
                    return
                }
                coordinator.showInfo(title, people: people)
            }
        }
    }
    
}

}
