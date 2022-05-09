//
//  model.swift
//  Navigation
//
//  Created by Егор Лазарев on 04.05.2022.
//

import Foundation

class FeedModel {
   
    var infoArray = ["Вот так выглядит моя витрина, а чего добился ты?", "На эту гребанную штуку потратил 74тыс руб"] //Сугубо для эксперементов
    weak var coordinator: FeedCoordinator?
    
    init(coordinator:FeedCoordinator){
        self.coordinator = coordinator
    }
    
    func check(word: String) -> Bool {
            return word == "Зеленый"
    }
    
    func getPost(sender: CustomButton) {
        let post = Post_old(title: sender.title(for: .normal)!, image: sender.image(for: .normal)!, info: infoArray[sender.tag])
        coordinator!.pushPost(post: post)
    }
    
}
