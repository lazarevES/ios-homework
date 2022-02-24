//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Егор Лазарев on 23.02.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    static let identifire = "PostTableViewCell"
    var authorView = UILabel()
    var descriptionView = UILabel()
    var image = UIImageView()
    var likesView = UILabel()
    var viewsView = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [authorView, descriptionView, image, likesView, viewsView].forEach({contentView.addSubview($0)})
        
        useConstraint()
    }
    
    public func specifyFields(post: Post) {
        authorView.text = post.author
        descriptionView.text = post.description
        image.image = UIImage(named: post.image)
        likesView.text = "Лайк: \(post.likes)"
        viewsView.text = "Просмотры: \(post.views)"
        
        needsUpdateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func useConstraint() {
        
        authorView.translatesAutoresizingMaskIntoConstraints = false
        authorView.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        authorView.textColor = .black
        authorView.numberOfLines = 2
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.font = UIFont.systemFont(ofSize: 14)
        descriptionView.textColor = UIColor.systemGray
        descriptionView.numberOfLines = 0
        
        likesView.translatesAutoresizingMaskIntoConstraints = false
        likesView.font = UIFont.systemFont(ofSize: 16)
        likesView.textColor = .black
        
        viewsView.translatesAutoresizingMaskIntoConstraints = false
        viewsView.font = UIFont.systemFont(ofSize: 16)
        viewsView.textColor = .black
        
        [authorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Const.leadingMargin),
         authorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Const.trailingMargin),
         authorView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Const.indent),
         authorView.heightAnchor.constraint(equalToConstant: 20),
         image.topAnchor.constraint(equalTo: authorView.bottomAnchor, constant: Const.indent),
         image.widthAnchor.constraint(equalTo: contentView.widthAnchor),
         image.heightAnchor.constraint(equalTo: contentView.widthAnchor),
         descriptionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Const.leadingMargin),
         descriptionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Const.trailingMargin),
         descriptionView.topAnchor.constraint(equalTo: image.bottomAnchor, constant: Const.indent),
         likesView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Const.leadingMargin),
         likesView.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: Const.indent),
         viewsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Const.trailingMargin),
         viewsView.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: Const.indent)].forEach { $0.isActive = true }
    }
    
    override func prepareForReuse() {
            super.prepareForReuse()
        }
}
