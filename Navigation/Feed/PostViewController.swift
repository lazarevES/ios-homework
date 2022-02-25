//
//  PostViewController.swift
//  Navigation
//
//  Created by Егор Лазарев on 08.02.2022.
//

import UIKit

struct Post {
    var title: String
}

class PostViewController: UIViewController {

    var post: Post?
    let infoViewController: InfoViewController
    
    init() {
        infoViewController = InfoViewController()
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
        
        if let thisPost = post {
            title = thisPost.title
        }
               
    }
    
    @objc func showInfo() {
        infoViewController.title = title
        present(infoViewController, animated: true, completion: nil)
    }

}
