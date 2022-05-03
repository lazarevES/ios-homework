//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Егор Лазарев on 01.03.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {

    static let identifire = "PhotosCollectionViewCell"
    
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
    
    func setupImage(_ image: UIImage) {
        photo.image = image
    }
    
}
