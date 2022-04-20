//
//  LogInViewController.swift
//  Navigation
//
//  Created by Егор Лазарев on 20.02.2022.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate  {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.isScrollEnabled = true
        scrollView.toAutoLayout()
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.toAutoLayout()
        return contentView
    }()
    
    lazy var logo: UIImageView = {
        let logo = UIImageView(image: UIImage(named: "logo"))
        logo.toAutoLayout()
        return logo
    }()
    
    lazy var userName: UITextField = {
        let userName = UITextField()
        userName.toAutoLayout()
        userName.textColor = .black
        userName.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        userName.tintColor = UIColor(named: "AccentColor")
        userName.autocapitalizationType = .none
        userName.layer.borderColor = UIColor.lightGray.cgColor
        userName.layer.borderWidth = 0.25
        userName.placeholder = "Email или телефон"
        userName.keyboardType = .emailAddress
        userName.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: userName.frame.height))
        userName.leftViewMode = .always
        userName.returnKeyType = .done
        return userName
    }()
    
    lazy var password: UITextField = {
        let password = UITextField()
        password.toAutoLayout()
        password.textColor = .black
        password.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        password.tintColor = UIColor(named: "AccentColor")
        password.autocapitalizationType = .none
        password.layer.borderColor = UIColor.lightGray.cgColor
        password.layer.borderWidth = 0.25
        password.isSecureTextEntry = true
        password.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: password.frame.height))
        password.leftViewMode = .always
        password.placeholder = "Пароль"
        password.returnKeyType = UIReturnKeyType.default
        return password
    }()
    
    lazy var logIn: UIButton = {
        let logIn = UIButton()
        logIn.toAutoLayout()
        logIn.setTitle("Вход", for: .normal)
        
        if let image = UIImage(named: "blue_pixel") {
            logIn.setBackgroundImage(image.imageWithAlpha(alpha: 1), for: .normal)
            logIn.setBackgroundImage(image.imageWithAlpha(alpha: 0.8), for: .selected)
            logIn.setBackgroundImage(image.imageWithAlpha(alpha: 0.8), for: .highlighted)
            logIn.setBackgroundImage(image.imageWithAlpha(alpha: 0.8), for: .disabled)
        }
        
        logIn.imageView?.contentMode = .scaleAspectFill
        logIn.titleLabel?.textColor = .white
        logIn.layer.cornerRadius = 10
        logIn.addTarget(self, action: #selector(login), for: .touchUpInside)
        logIn.clipsToBounds = true
        return logIn
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutoLayout()
        stackView.axis = .vertical
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
        stackView.distribution = .fillProportionally
        stackView.backgroundColor = .systemGray6
        stackView.clipsToBounds = true
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        scrollView.contentSize = CGSize(width: view.frame.width, height: max(view.frame.width, view.frame.height))
        
        contentView.addSubviews(logo, stackView, logIn)
        stackView.addArrangedSubview(userName)
        stackView.addArrangedSubview(password)
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
        
        useConstraint()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(tapGesture)
        
#if release
        userName.text = ""
#elseif DEBUG
        userName.text = "Киря"
#endif
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        NotificationCenter.default.addObserver(self, selector:
                                                #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector:
                                                #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    private func useConstraint() {
        
        NSLayoutConstraint.activate([scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                     
                                     contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                                     contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                                     contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                                     contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                                     contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                                     contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
                                     
                                     logo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Const.bigIndent),
                                     logo.widthAnchor.constraint(equalToConstant: Const.bigSize),
                                     logo.heightAnchor.constraint(equalToConstant: Const.bigSize),
                                     logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     
                                     stackView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: Const.bigIndent),
                                     stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Const.leadingMargin),
                                     stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Const.trailingMargin),
                                     stackView.heightAnchor.constraint(equalToConstant: Const.bigSize),
                                     
                                     logIn.topAnchor.constraint(equalTo: password.bottomAnchor, constant: Const.indent),
                                     logIn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Const.leadingMargin),
                                     logIn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Const.trailingMargin),
                                     logIn.heightAnchor.constraint(equalToConstant: Const.size)])
    }
    
    @objc func login() {
        
        var userService: UserService
        
#if release
        userService = CurrentUserService()
#elseif DEBUG
        userService = TestUserService()
#endif
        let profileViewController = ProfileViewController(userService: userService, name: userName.text ?? "")
        navigationController?.setViewControllers([profileViewController], animated: true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardRectangle = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            //scrollView.contentOffset.y = keyboardRectangle.height - (scrollView.frame.height - logIn.frame.minY) + Const.indent
            scrollView.contentInset.bottom = keyboardRectangle.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardRectangle.height, right: 0)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        //scrollView.contentOffset = CGPoint(x: 0, y: 0)
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    @objc func tap() {
        password.resignFirstResponder()
        userName.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        password.resignFirstResponder()
        userName.resignFirstResponder()
        return true;
    }
}

extension UIImage {
    func imageWithAlpha(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
