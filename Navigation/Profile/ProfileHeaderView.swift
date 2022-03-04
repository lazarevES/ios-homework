//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Егор Лазарев on 14.02.2022.
//

import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    var userName: UILabel = {
        let userName = UILabel()
        userName.toAutoLayout()
        userName.text = "Киря"
        userName.textAlignment = .natural
        userName.textColor = .black
        userName.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return userName
    }()
    
    lazy var avatar: UIImageView = {
        let avatar = UIImageView(image: UIImage(named: "avatar"))
        avatar.toAutoLayout()
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = 50
        avatar.layer.borderWidth = 3
        avatar.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.openAvatar))
        avatar.addGestureRecognizer(recognizer)
        avatar.isUserInteractionEnabled = true
        return avatar
    }()
    
    var status: UILabel = {
        let status = UILabel()
        status.toAutoLayout()
        status.text = "В ожидании еды"
        status.textAlignment = .natural
        status.textColor = .gray
        status.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        status.isUserInteractionEnabled = true
        return status
    }()
    
    var statusButton: UIButton = {
        let statusButton = UIButton()
        statusButton.toAutoLayout()
        statusButton.backgroundColor = #colorLiteral(red: 0.05408742279, green: 0.4763534069, blue: 0.9996182323, alpha: 1)
        statusButton.layer.cornerRadius = 4
        statusButton.layer.shadowColor = UIColor.black.cgColor
        statusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        statusButton.layer.shadowOpacity = 0.7
        statusButton.layer.shadowRadius = 4
        statusButton.setTitle("Установить статус", for: .normal)
        statusButton.setTitleColor(.white, for: .highlighted)
        statusButton.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        return statusButton
    }()
    
    var setStatusField: UITextField = {
        let setStatusField = UITextField()
        setStatusField.toAutoLayout()
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
        return setStatusField
    }()
    
    lazy var foneView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.toAutoLayout()
        view.backgroundColor = .darkGray
        view.isHidden = true
        view.alpha = 0
        return view
    }()
    
    var closeButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.toAutoLayout()
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = .darkGray
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(closeAvatar), for: .touchUpInside)
        return button
    }()
    
    private var statusText = ""
    private var defaultAvatarPosicion: CGPoint?
    static let identifire = "ProfileHeaderView"
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(userName, status, statusButton, setStatusField, foneView, avatar, closeButton)
        useConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    private func useConstraint() {
        
        //тут установим привязки
        
        [closeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Const.indent),
         closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Const.trailingMargin),
         closeButton.heightAnchor.constraint(equalToConstant: Const.smallSize),
            
         avatar.widthAnchor.constraint(equalToConstant: Const.bigSize),
         avatar.heightAnchor.constraint(equalTo: avatar.widthAnchor),
         avatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Const.leadingMargin),
         avatar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Const.indent),
         
         userName.leftAnchor.constraint(equalTo: avatar.rightAnchor, constant: Const.smallSize),
         userName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 27),
         userName.rightAnchor.constraint(greaterThanOrEqualTo: contentView.rightAnchor, constant: Const.trailingMargin),
         
         status.leftAnchor.constraint(equalTo: avatar.rightAnchor, constant: Const.smallSize),
         status.rightAnchor.constraint(greaterThanOrEqualTo: contentView.rightAnchor, constant: Const.trailingMargin),
         status.bottomAnchor.constraint(equalTo: setStatusField.topAnchor, constant: -6),
         
         statusButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
         statusButton.rightAnchor.constraint(greaterThanOrEqualTo: contentView.rightAnchor, constant: Const.trailingMargin),
         statusButton.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: Const.indent),
         statusButton.heightAnchor.constraint(equalToConstant: Const.size),
         
         setStatusField.leftAnchor.constraint(equalTo: avatar.rightAnchor, constant: Const.smallSize),
         setStatusField.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -10),
         setStatusField.rightAnchor.constraint(greaterThanOrEqualTo: contentView.rightAnchor, constant: Const.trailingMargin),
         setStatusField.heightAnchor.constraint(equalToConstant: 40)].forEach({$0.isActive = true})
        
    }
    
    @objc func openAvatar() {
        UIImageView.animate(
            withDuration: 0.5,
            animations: {
                self.defaultAvatarPosicion = self.avatar.center
                self.avatar.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
                self.avatar.transform = CGAffineTransform(scaleX: self.contentView.frame.width / self.avatar.frame.width,
                                                          y: self.contentView.frame.width / self.avatar.frame.width)
                self.avatar.layer.cornerRadius = 0
                self.foneView.isHidden = false
                self.foneView.alpha = 0.7
                self.avatar.isUserInteractionEnabled = false
                ProfileViewController.postTable.isScrollEnabled = false
            },
            completion: { _ in
                UIImageView.animate(withDuration: 0.3) {
                    self.closeButton.isHidden = false
                    self.closeButton.alpha = 1
                }
            })
    }
    
    @objc func closeAvatar() {
        UIImageView.animate(
            withDuration: 0.3,
            animations: {
                self.closeButton.alpha = 0
                self.closeButton.isHidden = true
                
            },
            completion: { _ in
                UIImageView.animate(withDuration: 0.5,
                                    animations: {
                    self.avatar.transform = CGAffineTransform(scaleX: 1, y: 1)
                    self.avatar.layer.cornerRadius = self.avatar.frame.width / 2
                    self.avatar.center = self.defaultAvatarPosicion!
                    self.foneView.alpha = 0.0
                    self.avatar.isUserInteractionEnabled = true
                    ProfileViewController.postTable.isScrollEnabled = true
                },
                                    completion: { _ in
                    self.foneView.isHidden = true
                })
            })
        
    }
    
    @objc func doNothing() {
        
    }
    
}
