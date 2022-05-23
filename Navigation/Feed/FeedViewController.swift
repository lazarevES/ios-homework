//
//  FeedViewController.swift
//  Navigation
//
//  Created by Егор Лазарев on 08.02.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    let model: FeedModel = FeedModel()
    
    lazy var stackView: UIStackView = {
        
        let stack = UIStackView()
        stack.toAutoLayout()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.alignment = .fill
        stack.backgroundColor = .clear
        return stack
    }()
    
    lazy var questionsStackView: UIStackView = {
        
        let stack = UIStackView()
        stack.toAutoLayout()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.alignment = .fill
        stack.backgroundColor = .clear
        return stack
    }()
    
    lazy var firstButton: CustomButton = {
        let button = CustomButton(vc: self,
                                  text: "Дом - милый дом",
                                  backgroundColor: .clear,
                                  backgroundImage: UIImage(named: "home"),
                                  tag: 0,
                                  shadow: true) {
            (vc: UIViewController, sender: CustomButton) in
            self.showPost(sender: sender)
        }
        
        button.layer.cornerRadius = 4
        return button
    }()
    
    lazy var secondButton: UIButton = {
        let button =  CustomButton(vc: self,
                                   text: "Лего сокол тысячелетия",
                                   backgroundColor: .clear,
                                   backgroundImage: UIImage(named: "LegoMillenniumFalcon"),
                                   tag: 1,
                                   shadow: true) {
            (vc: UIViewController, sender: CustomButton) in
            self.showPost(sender: sender)
        }
        button.layer.cornerRadius = 4
       
        return button
    }()
    
    lazy var answerTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.placeholder = "Зеленый"
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.textAlignment = .natural
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        textField.leftViewMode = .always
        return textField
    }()
   
    lazy var answerButton: CustomButton = {
        let button = CustomButton(vc: self,
                                  text: "Проверить текст",
                                  backgroundColor: #colorLiteral(red: 0.05408742279, green: 0.4763534069, blue: 0.9996182323, alpha: 1),
                                  backgroundImage: nil,
                                  tag: 0,
                                  shadow: true) {
            (vc:UIViewController, sender: CustomButton) in
            if self.model.check(word: self.answerTextField.text!) {
                sender.notification = {sender.textFieldArray.forEach({$0.textColor = UIColor.green})}
            }
            else {
                sender.notification = {sender.textFieldArray.forEach({$0.textColor = UIColor.red})}
            }
        }
        
        button.layer.cornerRadius = 4
        button.addTextField(textField: answerTextField)
        return button
    }()

    
    var infoArray = ["Вот так выглядит моя витрина, а чего добился ты?", "На эту гребанную штуку потратил 74тыс руб"] //Сугубо для эксперементов
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Новости"
        
        questionsStackView.addArrangedSubview(answerTextField)
        questionsStackView.addArrangedSubview(answerButton)
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        stackView.addArrangedSubview(questionsStackView)
        
        view.addSubview(stackView)
        useConstraint()
        
    }
    
    func useConstraint() {
        NSLayoutConstraint.activate([stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: Const.trailingMargin),
                                     stackView.heightAnchor.constraint(equalToConstant: view.bounds.height / 1.5)])
    }
    
    func showPost(sender: UIButton) {
        let postViewController = PostViewController(post:Post_old(title: sender.title(for: .normal)!,
                                                                  image: sender.image(for: .normal)!,
                                                                  info: infoArray[sender.tag]))
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
}
