//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Егор Лазарев on 23.02.2022.
//

import UIKit
import StorageService

class PostTableViewCell: UITableViewCell {
    
    static let identifire = "PostTableViewCell"
    let postView = PostView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(postView)
        useConstraint()
    }
    
    func useConstraint() {
        NSLayoutConstraint.activate([postView.topAnchor.constraint(equalTo: contentView.topAnchor),
                                     postView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                                     postView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                                     postView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
                                    ])
    }
        
    public func specifyFields(post: FeedPost) {
        postView.setupPost(post: post)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
