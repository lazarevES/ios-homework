//
//  Const.swift
//  Navigation
//
//  Created by Егор Лазарев on 23.02.2022.
//

import UIKit
import StorageService

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

let constPhotoArray = [UIImage(named:"foto1")!, UIImage(named:"foto2")!, UIImage(named:"foto3")!, UIImage(named:"foto4")!, UIImage(named:"foto5")!, UIImage(named:"foto6")!, UIImage(named:"foto8")!, UIImage(named:"foto9")!, UIImage(named:"foto10")!, UIImage(named:"foto11")!, UIImage(named:"foto12")!, UIImage(named:"foto13")!, UIImage(named:"foto14")!, UIImage(named:"foto15")!, UIImage(named:"foto16")!, UIImage(named:"foto17")!, UIImage(named:"foto18")!, UIImage(named:"foto19")!, UIImage(named:"foto20")!]
