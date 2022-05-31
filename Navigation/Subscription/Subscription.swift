//
//  Subscription.swift
//  Navigation
//
//  Created by Егор Лазарев on 24.05.2022.
//

import Foundation
import UIKit

class Subscription: UIViewController {
    
    lazy var reclame: UILabel = {
        let textView = UILabel()
        textView.toAutoLayout()
        textView.textColor = .black
        textView.text = "Здесь могла быть ваша реклама"
        textView.textAlignment = .center
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(reclame)
        
        NSLayoutConstraint.activate([reclame.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
                                     reclame.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Const.leadingMargin),
                                     reclame.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Const.trailingMargin),
                                     reclame.heightAnchor.constraint(equalToConstant: 20)
                                    ])
        
    }
    
}
