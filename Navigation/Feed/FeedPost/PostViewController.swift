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
        
        let infoBarButtonItem = UIBarButtonItem(title: "Инфо", style: .plain, target: self, action: #selector(showInfo))
        self.navigationItem.rightBarButtonItem  = infoBarButtonItem
      
        view.backgroundColor = UIColor.lightGray
        
        title = post.title
        
        let image = UIImageView(image: post.image)
        image.toAutoLayout()
        image.contentMode = .scaleAspectFit
       
        view.addSubview(image)
       
        NSLayoutConstraint.activate([image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     image.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
        
    }
    
    @objc func showInfo() {
        NetworkService.URLSessionDataTask(postInfo: post.info, type: post.postType) { title, people in
            DispatchQueue.main.async {
                guard let coordinator = self.coordinator as? FeedCoordinator else {
                    let coordinator = self.coordinator as? FavoriteCoordinator
                    coordinator?.showInfo(title, people: people)
                    return
                }
                coordinator.showInfo(title, people: people)
            }
        }
        
    }

}
