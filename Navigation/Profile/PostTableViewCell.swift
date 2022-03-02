//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Егор Лазарев on 23.02.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    static let identifire = "PostTableViewCell"
    
    var authorView: UILabel = {
        let authorView = UILabel()
        authorView.toAutoLayout()
        authorView.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        authorView.textColor = .black
        authorView.numberOfLines = 2
        return authorView
    }()
    
    var descriptionView: UILabel = {
        let descriptionView = UILabel()
        descriptionView.toAutoLayout()
        descriptionView.font = UIFont.systemFont(ofSize: 14)
        descriptionView.textColor = UIColor.systemGray
        descriptionView.numberOfLines = 0
        return descriptionView
    }()
    
    var image: UIImageView = {
        let image = UIImageView()
        image.toAutoLayout()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        return image
    }()
    
    var likesView: UILabel = {
        let likesView = UILabel()
        likesView.toAutoLayout()
        likesView.font = UIFont.systemFont(ofSize: 16)
        likesView.textColor = .black
        return likesView
    }()
    
    var viewsView: UILabel = {
        let viewsView = UILabel()
        viewsView.toAutoLayout()
        viewsView.font = UIFont.systemFont(ofSize: 16)
        viewsView.textColor = .black
        return viewsView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(authorView, descriptionView, image, likesView, viewsView)
        useConstraint()
    }
    
    func useConstraint() {
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
         descriptionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -48),
         likesView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Const.leadingMargin),
         likesView.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: Const.indent),
         likesView.heightAnchor.constraint(equalToConstant: Const.indent),
         viewsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Const.trailingMargin),
         viewsView.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: Const.indent),
         viewsView.heightAnchor.constraint(equalToConstant: Const.indent),].forEach { $0.isActive = true }
    }
    
    public func specifyFields(post: Post) {
        authorView.text = post.author
        descriptionView.text = post.description
        image.image = UIImage(named: post.image)
        likesView.text = "Лайк: \(post.likes)"
        viewsView.text = "Просмотры: \(post.views)"
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
