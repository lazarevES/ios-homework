//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Егор Лазарев on 14.02.2022.
//

import UIKit
import SnapKit

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    lazy var userName: UILabel = {
        let userName = UILabel()
		userName.text = "userNotFound".localized
        userName.textAlignment = .natural
        userName.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        userName.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return userName
    }()
    
    lazy var avatar: UIImageView = {
        let avatar = UIImageView()
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = 50
        avatar.layer.borderWidth = 3
        avatar.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.openAvatar))
        avatar.addGestureRecognizer(recognizer)
        avatar.isUserInteractionEnabled = true
        return avatar
    }()
    
    lazy var status: UILabel = {
        let status = UILabel()
        status.text = ""
        status.textAlignment = .natural
        status.textColor = UIColor.createColor(lightMode: .gray, darkMode: .lightGray)
        status.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        status.isUserInteractionEnabled = true
        return status
    }()
    
    lazy var statusButton: UIButton = {
        let statusButton = UIButton()
        statusButton.backgroundColor = #colorLiteral(red: 0.05408742279, green: 0.4763534069, blue: 0.9996182323, alpha: 1)
        statusButton.layer.cornerRadius = 4
        statusButton.layer.shadowColor = UIColor.black.cgColor
        statusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        statusButton.layer.shadowOpacity = 0.7
        statusButton.layer.shadowRadius = 4
		statusButton.setTitle("setStatus".localized, for: .normal)
        statusButton.setTitleColor(.white, for: .highlighted)
        statusButton.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        return statusButton
    }()
    
    lazy var setStatusField: UITextField = {
        let setStatusField = UITextField()
        setStatusField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
		setStatusField.placeholder = "setStatus".localized
        setStatusField.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        setStatusField.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .darkGray)
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
        view.backgroundColor = UIColor.createColor(lightMode: .darkGray, darkMode: .lightGray)
        view.isHidden = true
        view.alpha = 0
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = UIColor.createColor(lightMode: .darkGray, darkMode: .lightGray)
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
    
    public func initUserData(user: User) {
        userName.text = user.name
        avatar.image = user.avatar
        status.text = user.status
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
        
        avatar.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview().offset(Const.indent)
            make.leading.equalToSuperview().offset(Const.leadingMargin)
            make.height.width.equalTo(Const.bigSize)
        }
        
        closeButton.snp.makeConstraints { (make) -> Void in
            make.top.trailing.equalToSuperview().inset(Const.indent)
        }

        userName.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview().inset(27)
            make.leading.equalTo(avatar.snp.trailing).offset(Const.smallSize)
            make.trailing.equalToSuperview().offset(Const.trailingMargin)
        }

        status.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(avatar.snp.trailing).offset(Const.smallSize)
            make.bottom.equalTo(setStatusField.snp.top).offset(-12)
        }

        statusButton.snp.makeConstraints { (make) -> Void in
            make.leading.trailing.equalToSuperview().inset(Const.leadingMargin)
            make.top.equalTo(avatar.snp.bottom).offset(Const.indent)
            make.height.equalTo(Const.size)
        }

        setStatusField.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(avatar.snp.trailing).offset(Const.smallSize)
            make.bottom.equalTo(statusButton.snp.top).inset(-10)
            make.trailing.equalToSuperview().offset(Const.trailingMargin)
            make.height.equalTo(40)
        }
        
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
                //ProfileViewController.postTable.isScrollEnabled = false
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
                },
                                    completion: { _ in
                    self.foneView.isHidden = true
                })
            })
        
    }
    
    @objc func doNothing() {
        
    }
    
}
