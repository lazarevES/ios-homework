//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Егор Лазарев on 14.02.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    
    var userName: UILabel
    var avatar: UIImageView
    var status: UILabel
    var statusButton: UIButton
    var setStatusField: UITextField
    private var statusText = ""
    
    init() {
        
        //Инициализируем элементы
        userName = UILabel()
        status = UILabel()
        avatar = UIImageView(image: UIImage(named: "avatar"))
        statusButton = UIButton()
        setStatusField = UITextField()
        super.init(frame: CGRect())
        
        
        //Заполним свойства элементов
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.text = "Киря"
        userName.textAlignment = .natural
        userName.textColor = .black
        userName.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        self.addSubview(userName)
        
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = 50
        avatar.layer.borderWidth = 3
        avatar.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        self.addSubview(avatar)
        
        status.translatesAutoresizingMaskIntoConstraints = false
        status.text = "В ожидании еды"
        status.textAlignment = .natural
        status.textColor = .gray
        status.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        status.isUserInteractionEnabled = true
        self.addSubview(status)
        
        statusButton.translatesAutoresizingMaskIntoConstraints = false
        statusButton.backgroundColor = #colorLiteral(red: 0.05408742279, green: 0.4763534069, blue: 0.9996182323, alpha: 1)
        statusButton.layer.cornerRadius = 4
        statusButton.layer.shadowColor = UIColor.black.cgColor
        statusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        statusButton.layer.shadowOpacity = 0.7
        statusButton.layer.shadowRadius = 4
        statusButton.setTitle("Установить статус", for: .normal)
        statusButton.setTitleColor(.white, for: .highlighted)
        statusButton.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        self.addSubview(statusButton)
        
        setStatusField.translatesAutoresizingMaskIntoConstraints = false
        setStatusField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        setStatusField.placeholder = "Ввести статус"
        setStatusField.textColor = .black
        setStatusField.backgroundColor = .white
        setStatusField.textAlignment = .natural
        setStatusField.layer.cornerRadius = 12
        setStatusField.layer.borderWidth = 1
        setStatusField.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        setStatusField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: setStatusField.frame.height))
        setStatusField.leftViewMode = .always
        setStatusField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        
        self.addSubview(setStatusField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //тут установим привязки
        NSLayoutConstraint.activate([self.leftAnchor.constraint(equalTo: superview!.leftAnchor),
                                     self.rightAnchor.constraint(equalTo: superview!.rightAnchor),
                                     self.topAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.topAnchor),
                                     self.heightAnchor.constraint(equalToConstant: 220),
                                     
                                     avatar.widthAnchor.constraint(equalToConstant: 100),
                                     avatar.heightAnchor.constraint(equalTo: avatar.widthAnchor),
                                     avatar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
                                     avatar.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
                                     
                                     userName.leftAnchor.constraint(equalTo: avatar.rightAnchor, constant: 20),
                                     userName.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
                                     userName.rightAnchor.constraint(greaterThanOrEqualTo: self.rightAnchor, constant: -16),
                                     
                                     status.leftAnchor.constraint(equalTo: avatar.rightAnchor, constant: 20),
                                     status.rightAnchor.constraint(greaterThanOrEqualTo: self.rightAnchor, constant: -16),
                                     status.bottomAnchor.constraint(equalTo: setStatusField.topAnchor, constant: -6),
                                     
                                     statusButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
                                     statusButton.rightAnchor.constraint(greaterThanOrEqualTo: self.rightAnchor, constant: -16),
                                     statusButton.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 16),
                                     statusButton.heightAnchor.constraint(equalToConstant: 50),
                                     
                                     setStatusField.leftAnchor.constraint(equalTo: avatar.rightAnchor, constant: 20),
                                     setStatusField.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -10),
                                     setStatusField.rightAnchor.constraint(greaterThanOrEqualTo: self.rightAnchor, constant: -16),
                                     setStatusField.heightAnchor.constraint(equalToConstant: 40)])
        
    }
    
    @objc func pressButton() {
        //print(status.text) первая часть задания
        status.text = statusText
        statusText = ""
        setStatusField.text = ""
        setStatusField.resignFirstResponder()
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        if let text = textField.text {
            statusText = text
        }
    }
    
}
