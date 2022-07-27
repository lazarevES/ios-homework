//
//  FavoriteViewCell.swift
//  Navigation
//
//  Created by Егор Лазарев on 26.07.2022.
//

import Foundation
import UIKit

protocol FavoritePostCollectionViewCellDelegate: AnyObject {
    func tapToPost(with post: FeedPost)
    func showPost(post: FeedPost)
}

class FavoritePostCollectionViewCell: UITableViewCell {

    static let identifire = "FavoritePostCollectionViewCell"
    weak var delegate: FavoritePostCollectionViewCellDelegate?
    var post: FeedPost?
    let postView = PostView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(postView)
        
        let firstTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        firstTapGestureRecognizer.numberOfTapsRequired = 1
        firstTapGestureRecognizer.numberOfTouchesRequired = 1
        firstTapGestureRecognizer.isEnabled = true
        
        
        let secondTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageDoubleTapped))
        secondTapGestureRecognizer.numberOfTapsRequired = 2
        secondTapGestureRecognizer.numberOfTouchesRequired = 1
        secondTapGestureRecognizer.isEnabled = true
        contentView.isUserInteractionEnabled = true
        firstTapGestureRecognizer.require(toFail: secondTapGestureRecognizer)
        contentView.addGestureRecognizer(firstTapGestureRecognizer)
        contentView.addGestureRecognizer(secondTapGestureRecognizer)
        
        useConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func useConstraint() {
        NSLayoutConstraint.activate([postView.topAnchor.constraint(equalTo: contentView.topAnchor),
                                     postView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                                     postView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                                     postView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
                                    ])
    }
    
    func setupPost(_ post: FeedPost) {
        self.post = post
        postView.setupPost(post: post)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if let delegate = delegate, let post = post {
            delegate.showPost(post: post)
        }
    }
    
    @objc func imageDoubleTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if let delegate = delegate, let post = post {
            delegate.tapToPost(with: post)
        }
    }
    
}
