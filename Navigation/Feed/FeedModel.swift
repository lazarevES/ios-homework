//
//  model.swift
//  Navigation
//
//  Created by Егор Лазарев on 04.05.2022.
//

import Foundation
import UIKit

struct FeedPost {
    var title: String
    var image: UIImage
    var info: String
    var postType: PostType
}

enum PostType {
    case testStruct
    case planet
    case resident
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
        let firstPost = FeedPost(title: "Первое задание",
                                 image: UIImage(named: "zadanie-1.png")!,
                                 info: "https://jsonplaceholder.typicode.com/todos/" + String(Int.random(in: 1...20)),
                                 postType: .testStruct)
        
        postArray.append(firstPost)
        let secondPost = FeedPost(title: "Татуин",
                                  image: UIImage(named: "Татуин.jgp")!,
                                  info: "https://swapi.dev/api/planets/1",
                                  postType: .planet)
        
        postArray.append(secondPost)
        return postArray
    }
        
}
