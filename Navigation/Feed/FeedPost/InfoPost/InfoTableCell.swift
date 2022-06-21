//
//  InfoTableCell.swift
//  Navigation
//
//  Created by Егор Лазарев on 21.06.2022.
//

import Foundation
import UIKit

class InfoTableCell: UITableViewCell {
    
    static let identifire = "InfoTableCell"
    var name = "" {
        didSet {
            nameLabel.text = name
        }
    }
    
    var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.toAutoLayout()
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.textColor = .white
        return nameLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(nameLabel)
        contentView.backgroundColor = .darkGray
        useConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func useConstraint() {
        NSLayoutConstraint.activate([nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Const.leadingMargin),
                                     nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Const.trailingMargin),
                                     nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
                                     ])
    }
    
    public func specifyFields(name: String) {
        self.name = name
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
