//
//  PostView.swift
//  Navigation
//
//  Created by Егор Лазарев on 27.07.2022.
//

import Foundation
import UIKit

class PostView: UIView {

    var authorView: UILabel = {
        let authorView = UILabel()
        authorView.toAutoLayout()
        authorView.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        authorView.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        authorView.numberOfLines = 2
        return authorView
    }()
    
    var descriptionView: UILabel = {
        let descriptionView = UILabel()
        descriptionView.toAutoLayout()
        descriptionView.font = UIFont.systemFont(ofSize: 14)
        descriptionView.textColor = UIColor.createColor(lightMode: .systemGray, darkMode: .systemGray6)
        descriptionView.numberOfLines = 0
        return descriptionView
    }()
    
    var image: UIImageView = {
        let image = UIImageView()
        image.toAutoLayout()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        return image
    }()
    
    var likesView: UILabel = {
        let likesView = UILabel()
        likesView.toAutoLayout()
        likesView.font = UIFont.systemFont(ofSize: 16)
        likesView.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        return likesView
    }()
    
    var viewsView: UILabel = {
        let viewsView = UILabel()
        viewsView.toAutoLayout()
        viewsView.font = UIFont.systemFont(ofSize: 16)
        viewsView.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        return viewsView
    }()
    
    init() {
        super.init(frame: .zero)
        self.toAutoLayout()
        self.addSubviews(authorView, descriptionView, image, likesView, viewsView)
        useConstraint()
    }
    
    func setupPost(post: FeedPost, isFavorite: Bool? = nil) {
        authorView.text = post.author
        image.image = post.image
        descriptionView.text = post.description
        if let isFavorite = isFavorite {
			let notLike = (traitCollection.userInterfaceStyle == .dark ? "🤍": "🖤")
			likesView.text = "like".localizedNumeric(numeric: post.likes + (isFavorite ? 1: 0)) + (isFavorite ? "❤️": notLike)
        } else {
            likesView.text = "like".localizedNumeric(numeric: post.likes)
        }
        viewsView.text = "like".localizedNumeric(numeric: post.views)
    }
    
    func postToFullScreen() {
        NSLayoutConstraint.activate([image.centerYAnchor.constraint(equalTo: self.centerYAnchor)])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func useConstraint() {
        NSLayoutConstraint.activate([
			authorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Const.leadingMargin),
			authorView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Const.trailingMargin),
			authorView.topAnchor.constraint(equalTo: self.topAnchor, constant: Const.indent),
			authorView.heightAnchor.constraint(equalToConstant: Const.smallSize),
			image.topAnchor.constraint(equalTo: authorView.bottomAnchor, constant: Const.indent),
			image.widthAnchor.constraint(equalTo: self.widthAnchor),
			image.heightAnchor.constraint(equalTo: self.widthAnchor),
			descriptionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Const.leadingMargin),
			descriptionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Const.trailingMargin),
			descriptionView.topAnchor.constraint(equalTo: image.bottomAnchor, constant: Const.indent),
			//descriptionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -48),
			descriptionView.heightAnchor.constraint(equalToConstant: 20),
			likesView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Const.leadingMargin),
			likesView.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: Const.indent),
			likesView.heightAnchor.constraint(equalToConstant: Const.indent),
			likesView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Const.trailingMargin),
			viewsView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Const.trailingMargin),
			viewsView.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: Const.indent),
			viewsView.heightAnchor.constraint(equalToConstant: Const.indent),
			viewsView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Const.trailingMargin)
		])
    }
    
}
