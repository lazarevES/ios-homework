//
//  Const.swift
//  Navigation
//
//  Created by Егор Лазарев on 23.02.2022.
//

import UIKit

struct Const {
    
    static let leadingMargin: CGFloat = 16
    static let trailingMargin: CGFloat = -16
    static let indent: CGFloat = 16
    
}

struct Post {
    var author: String
    var description: String
    var image: String
    var likes: Int
    var views: Int
}

let constPostArray = [Post(author: "Киря", description: "my life...", image: "post1", likes: 7, views: 9),
                 Post(author: "Киря", description: "my bathroom...", image: "post2", likes: 7, views: 12),
                 Post(author: "Киря", description: "my step...", image: "post3", likes: 11, views: 24),
                 Post(author: "Киря", description: "Кого не любят канибалы? Людей без вкуса!", image: "post4", likes: 0, views: 30)]

