//
//  PostCollectionViewCell.swift
//  Navigation
//
//  Created by Егор Лазарев on 21.06.2022.
//

import Foundation
import UIKit
import StorageService

protocol PostCollectionViewCellDelegate: AnyObject {
    func tapToPost(with post: FeedPost, isFavorite: Bool)
    func showPost(post: FeedPost)
}

class PostCollectionViewCell: UICollectionViewCell {

    static let identifire = "PostCollectionViewCell"
    weak var delegate: PostCollectionViewCellDelegate?
    var post: FeedPost?
    var isFavorite = false
    
    let postView = PostView()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubviews(postView)
        
        let firstTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        firstTapGestureRecognizer.numberOfTapsRequired = 1
        firstTapGestureRecognizer.numberOfTouchesRequired = 1
        
        let secondTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageDoubleTapped))
        secondTapGestureRecognizer.numberOfTapsRequired = 2
        secondTapGestureRecognizer.numberOfTouchesRequired = 1
        
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
    
    func setupPost(_ post: FeedPost, isFavorite: Bool) {
        postView.setupPost(post: post, isFavorite: isFavorite)
        self.post = post
		self.isFavorite = isFavorite
    }
    
    @objc func imageTapped()
    {
        if let delegate = delegate, let post = post {
            delegate.showPost(post: post)
        }
    }
    
    @objc func imageDoubleTapped()
    {
        if let delegate = delegate, let post = post {
            delegate.tapToPost(with: post, isFavorite: isFavorite)
            isFavorite.toggle()
        }
    }
    
}

