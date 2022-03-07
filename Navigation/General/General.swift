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
    static let smallIndent: CGFloat = 8
    static let smallSize: CGFloat = 20
    static let size: CGFloat = 50
    static let bigSize: CGFloat = 100
    static let bigIndent: CGFloat = 120
    
}

struct Post {
    var author: String
    var description: String
    var image: String
    var likes: Int
    var views: Int
}

public extension UIView {

    func toAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }

}

let constPostArray = [Post(author: "Киря", description: "my life...", image: "post1", likes: 7, views: 9),
                 Post(author: "Киря", description: "my bathroom...", image: "post2", likes: 7, views: 12),
                 Post(author: "Киря", description: "my step...", image: "post3", likes: 11, views: 24),
                 Post(author: "Киря", description: "Кого не любят канибалы? Людей без вкуса!", image: "post4", likes: 0, views: 30)]

let constPhotoArray = ["foto1", "foto2", "foto3", "foto4", "foto5", "foto6", "foto7", "foto8", "foto9", "foto10", "foto11", "foto12", "foto13", "foto14", "foto15", "foto16", "foto17", "foto18", "foto19", "foto20"]
