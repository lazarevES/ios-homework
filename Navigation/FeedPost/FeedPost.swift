//
//  Post.swift
//  StorageService
//
//  Created by Егор Лазарев on 13.04.2022.
//

import Foundation
import UIKit

struct FeedPost {
    
    var id: Int
    var title: String
    var author: String
    var description: String
    var imageName: String
    var image: UIImage {
        get {
            UIImage(named: imageName)!
        }
    }
    var likes: Int
    var views: Int
    var postType: PostType
    
    var keyedValues: [String: Any] {
        return [
            "id": self.id,
            "title": self.title,
            "author": self.author,
            "imageName": self.imageName,
            "info": self.description,
            "postType": self.postType.rawValue,
            "likes": self.likes,
            "views": self.views
        ]
    }
    
    public init(id: Int, title: String, author: String, description: String, image: String, likes: Int, views: Int, postType: PostType) {
        self.id = id
        self.title = title
        self.author = author
        self.description = description
        self.imageName = image
        self.likes = likes
        self.views = views
        self.postType = postType
    }
    
    init(postCoreDataModel: FavoriteFeedPost) {
        self.id = Int(postCoreDataModel.id)
        self.title = postCoreDataModel.title!
        self.author = postCoreDataModel.author!
        self.description = postCoreDataModel.info!
        self.imageName = postCoreDataModel.imageName!
        self.likes = Int(postCoreDataModel.likes)
        self.views = Int(postCoreDataModel.views)
        self.postType = PostType.init(rawValue: Int(postCoreDataModel.postType))!
        
    }
    
}

extension FeedPost: Equatable {
	
}


enum PostType: Int {
    case post = 0
    case webDescription = 1
    case planet = 2
    case resident = 3
}
