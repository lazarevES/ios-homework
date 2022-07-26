//
//  model.swift
//  Navigation
//
//  Created by Егор Лазарев on 04.05.2022.
//

import Foundation
import UIKit

struct FeedPost {
    
    var id: Int
    var title: String
    var imageName: String
    var image: UIImage {
        get {
            UIImage(named: imageName)!
        }
    }
    var info: String
    var postType: PostType
    
    var keyedValues: [String: Any] {
        return [
            "id": self.id,
            "title": self.title,
            "imageName": self.imageName,
            "info": self.info,
            "postType": self.postType.rawValue,
        ]
    }
    
    init(PostCoreDataModel: FavoriteFeedPost) {
        self.id = Int(PostCoreDataModel.id)
        self.title = PostCoreDataModel.title!
        self.imageName = PostCoreDataModel.imageName!
        self.postType = PostType.init(rawValue: Int(PostCoreDataModel.postType))!
        self.info = PostCoreDataModel.info!
    }
    
    init(id: Int, title: String, imageName: String, info: String, postType: PostType) {
        self.id = id
        self.title = title
        self.imageName = imageName
        self.postType = postType
        self.info = info
    }
}

enum PostType: Int {
    case testStruct = 1
    case planet = 2
    case resident = 3
}

struct TestStruct: Codable {
    var title: String
}

struct Planet: Codable {
    var orbitalPeriod: String
    var residents: [String]
    
    enum CodingKeys: String, CodingKey {
        case orbitalPeriod = "orbital_period"
        case residents
    }
}

struct Resident: Codable {
    var name: String
}

class FeedModel {
    
    weak var coordinator: FeedCoordinator?
    
    init(coordinator:FeedCoordinator){
        self.coordinator = coordinator
    }
    
    func getPost() -> [FeedPost] {
        
        var postArray = [FeedPost]()
        let firstPost = FeedPost(id: 1,
                                 title: "Первое задание",
                                 imageName: "zadanie-1.png",
                                 info: "https://jsonplaceholder.typicode.com/todos/" + String(Int.random(in: 1...20)),
                                 postType: .testStruct)
        
        postArray.append(firstPost)
        let secondPost = FeedPost(id: 2,
                                  title: "Татуин",
                                  imageName: "Татуин.jgp",
                                  info: "https://swapi.dev/api/planets/1",
                                  postType: .planet)
        
        postArray.append(secondPost)
        return postArray
    }
    
}
