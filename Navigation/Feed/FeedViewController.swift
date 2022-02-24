//
//  FeedViewController.swift
//  Navigation
//
//  Created by Егор Лазарев on 08.02.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    let stackView: UIStackView
    var infoArray = [String]() //Сугубо для эксперементов
    
    init() {
        stackView = UIStackView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Новости"
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.backgroundColor = .clear
        
        let firstButton = UIButton()
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        firstButton.backgroundColor = .clear
        firstButton.layer.cornerRadius = 4
        firstButton.layer.shadowColor = UIColor.black.cgColor
        firstButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        firstButton.layer.shadowOpacity = 0.7
        firstButton.layer.shadowRadius = 4
        firstButton.setTitle("Дом - милый дом", for: .normal)
        firstButton.imageView?.contentMode = .scaleAspectFit
        firstButton.setImage(UIImage(named: "home"), for: .normal)
        firstButton.setTitleColor(.white, for: .highlighted)
        firstButton.addTarget(self, action: #selector(showPost), for: .touchUpInside)
        firstButton.tag = 0
        infoArray.append("Вот так выглядит моя витрина, а чего добился ты?")
        
        stackView.addArrangedSubview(firstButton)
        
        let secondButton = UIButton()
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        secondButton.backgroundColor = .clear
        secondButton.layer.cornerRadius = 4
        secondButton.layer.shadowColor = UIColor.black.cgColor
        secondButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        secondButton.layer.shadowOpacity = 0.7
        secondButton.layer.shadowRadius = 4
        secondButton.setTitle("Лего сокол тысячелетия", for: .normal)
        secondButton.setImage(UIImage(named: "LegoMillenniumFalcon"), for: .normal)
        secondButton.imageView?.contentMode = .scaleAspectFit
        secondButton.setTitleColor(.white, for: .highlighted)
        secondButton.addTarget(self, action: #selector(showPost), for: .touchUpInside)
        secondButton.tag = 1
        infoArray.append("На эту гребанную штуку потратил 74тыс руб")
        
        stackView.addArrangedSubview(secondButton)
        
        view.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -16).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: view.bounds.height / 1.5).isActive = true
        
    }
    
    @objc func showPost(sender: UIButton) {
        let postViewController = PostViewController(post:Post(title: sender.title(for: .normal)!,
                                                              image: sender.image(for: .normal)!,
                                                              info: infoArray[sender.tag]))
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    

    
}
