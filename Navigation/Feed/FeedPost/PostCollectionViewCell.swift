//
//  PostCollectionViewCell.swift
//  Navigation
//
//  Created by Егор Лазарев on 21.06.2022.
//

import Foundation
import UIKit

class PostCollectionViewCell: UICollectionViewCell {

    static let identifire = "PostCollectionViewCell"
    
    let photo: UIImageView = {
        let photo = UIImageView()
        photo.toAutoLayout()
        return photo
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(photo)
        
        useConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func useConstraint() {
        NSLayoutConstraint.activate([photo.topAnchor.constraint(equalTo: contentView.topAnchor),
                                     photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                                     photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                                     photo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
                                    ])
    }
    
    func setupPost(_ post: FeedPost) {
        photo.image = post.image
    }
    
}
