//
//  FeedViewController.swift
//  Navigation
//
//  Created by Егор Лазарев on 08.02.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    lazy var stackView: UIStackView = {
        
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.alignment = .fill
        stack.backgroundColor = .clear
        return stack
    }()
    
    lazy var firstButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.backgroundColor = .clear
        button.layer.cornerRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4
        button.setTitle("Дом - милый дом", for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: "home"), for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.addTarget(self, action: #selector(showPost), for: .touchUpInside)
        button.tag = 0
        return button
    }()
    
    lazy var secondButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.backgroundColor = .clear
        button.layer.cornerRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4
        button.setTitle("Лего сокол тысячелетия", for: .normal)
        button.setImage(UIImage(named: "LegoMillenniumFalcon"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.setTitleColor(.white, for: .highlighted)
        button.addTarget(self, action: #selector(showPost), for: .touchUpInside)
        button.tag = 1
        return button
    }()
    
    var infoArray = ["Вот так выглядит моя витрина, а чего добился ты?", "На эту гребанную штуку потратил 74тыс руб"] //Сугубо для эксперементов
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Новости"
        
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        
        view.addSubview(stackView)
        useConstraint()
        
    }
    
    func useConstraint() {
        NSLayoutConstraint.activate([stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: Const.trailingMargin),
                                     stackView.heightAnchor.constraint(equalToConstant: view.bounds.height / 1.5)])
    }
    
    @objc func showPost(sender: UIButton) {
        let postViewController = PostViewController(post:Post_old(title: sender.title(for: .normal)!,
                                                                  image: sender.image(for: .normal)!,
                                                                  info: infoArray[sender.tag]))
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
    
    
}
