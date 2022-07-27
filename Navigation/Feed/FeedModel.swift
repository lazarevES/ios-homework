//
//  model.swift
//  Navigation
//
//  Created by Егор Лазарев on 04.05.2022.
//

import Foundation
import UIKit

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
        return constPosts
    }
    
}
