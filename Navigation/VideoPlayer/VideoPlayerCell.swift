//
//  VideoPlayerCell.swift
//  Navigation
//
//  Created by Егор Лазарев on 01.06.2022.
//

import Foundation
import UIKit

class VideoPlayerCell: UITableViewCell {
    
    static let identifire = "VideoPlayerCell"
    var name = "" {
        didSet {
            nameLabel.text = name
        }
    }
    var URL: URL?
    
    var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.toAutoLayout()
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.textColor = .black
        return nameLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(nameLabel)
        useConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func useConstraint() {
        NSLayoutConstraint.activate([nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Const.leadingMargin),
                                     nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Const.trailingMargin)
                                     ])
    }
    
    public func specifyFields(name: String, url: URL) {
        self.name = name
        self.URL = url
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}

