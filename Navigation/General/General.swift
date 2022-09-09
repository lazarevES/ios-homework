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
    static let postSizeWidth: CGFloat = UIScreen.main.bounds.width - 32
    static let postSizeHeight: CGFloat = UIScreen.main.bounds.width + 100
    
}

enum AppError: Error {
    case unauthorized
    case notFound
    case badData
    case internalServer
}

public extension UIView {

    func toAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }

}

extension NSNotification.Name {
    static let wasLikedPost = NSNotification.Name("wasLikedPost")
    static let didRemovePostFromFavorites = NSNotification.Name("didRemovePostFromFavorites")
}

let constPosts = [FeedPost(id: 1,
                           title: "Первое задание",
                           author: "Скайвокер",
                           description: "https://jsonplaceholder.typicode.com/todos/" + String(Int.random(in: 1...20)),
                           image: "zadanie-1.png",
                           likes: 6,
                           views: 7,
                           postType: .webDescription),
                  FeedPost(id: 2,
                           title: "Татуин",
                           author: "Вейдер",
                           description: "https://swapi.dev/api/planets/1",
                           image: "Татуин.jgp",
                           likes: 32424122,
                           views: 32423123,
                           postType: .planet),
                  FeedPost(id: 3,
                           title: "my life",
                           author: "Киря",
                           description: "my life...",
                           image: "post1",
                           likes: 7,
                           views: 9,
                           postType: .post),
                  FeedPost(id: 4,
                           title: "my bathroom",
                           author: "Киря",
                           description: "my bathroom...",
                           image: "post2",
                           likes: 7,
                           views: 12,
                           postType: .post),
                  FeedPost(id: 5,
                           title: "my step",
                           author: "Киря",
                           description: "my step...",
                           image: "post3",
                           likes: 11,
                           views: 24,
                           postType: .post),
                  FeedPost(id: 6,
                           title: "Шутка",
                           author: "Киря",
                           description: "Кого не любят канибалы? Людей без вкуса!",
                           image: "post4",
                           likes: 0,
                           views: 30,
                           postType: .post)]

let constPhotoArray = [UIImage(named:"foto1")!, UIImage(named:"foto2")!, UIImage(named:"foto3")!, UIImage(named:"foto4")!, UIImage(named:"foto5")!, UIImage(named:"foto6")!, UIImage(named:"foto8")!, UIImage(named:"foto9")!, UIImage(named:"foto10")!, UIImage(named:"foto11")!, UIImage(named:"foto12")!, UIImage(named:"foto13")!, UIImage(named:"foto14")!, UIImage(named:"foto15")!, UIImage(named:"foto16")!, UIImage(named:"foto17")!, UIImage(named:"foto18")!, UIImage(named:"foto19")!, UIImage(named:"foto20")!]

extension String {
    
    static let empty = ""
    static let whitespace: Character = " "
	
	var localized: String { NSLocalizedString(self, comment: "") }
    
    var isFirstCharacterWhitespace: Bool {
        return self.first == Self.whitespace
    }
	
	func localizedNumeric(numeric: Int) -> String {
		
		var string = NSLocalizedString(self, comment: "")
		string = String.localizedStringWithFormat(string, numeric)
		return string
	}


    func toDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
    
    /// Замена паттерна строкой.
    /// - Parameters:
    ///   - pattern: Regex pattern.
    ///   - replacement: Строка, на что заменить паттерн.
    func replace(_ pattern: String, replacement: String) throws -> String {
        let regex = try NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
        return regex.stringByReplacingMatches(in: self,
                                              options: [.withTransparentBounds],
                                              range: NSRange(location: 0, length: self.count),
                                              withTemplate: replacement)
    }
    
    static func randomString(length: Int = 36) -> Self {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
      return String((0..<length).compactMap { _ in letters.randomElement() })
    }

}

extension UIColor {
	static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
		guard #available(iOS 13.0, *) else {
			return lightMode
		}
		return UIColor { (traitCollection) -> UIColor in
			return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
		}
	}
}
