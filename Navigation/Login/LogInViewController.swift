//
//  LogInViewController.swift
//  Navigation
//
//  Created by Егор Лазарев on 20.02.2022.
//
import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate  {
    
    var delegate: LoginViewControllerDelegate?
    var callback: (_ authenticationData: (userService: UserService, name: String)) -> Void
	var localAuthorizationService = LocalAuthorizationService()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
		scrollView.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .darkGray)
        scrollView.isScrollEnabled = true
        scrollView.toAutoLayout()
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .darkGray)
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
		userName.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .lightGray)
        userName.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        userName.tintColor = UIColor(named: "AccentColor")
        userName.autocapitalizationType = .none
        userName.layer.borderColor = UIColor.lightGray.cgColor
        userName.layer.borderWidth = 0.25
		userName.placeholder = "emailOrPhone".localized
        userName.keyboardType = .emailAddress
        userName.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: userName.frame.height))
        userName.leftViewMode = .always
        userName.returnKeyType = .done
        userName.addTarget(self, action: #selector(editingEnded), for: .editingChanged)
        return userName
    }()
    
    lazy var password: UITextField = {
        let password = UITextField()
        password.toAutoLayout()
        password.textColor = .black
		password.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .lightGray)
        password.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        password.tintColor = UIColor(named: "AccentColor")
        password.autocapitalizationType = .none
        password.layer.borderColor = UIColor.lightGray.cgColor
        password.layer.borderWidth = 0.25
        password.isSecureTextEntry = true
        password.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: password.frame.height))
        password.leftViewMode = .always
		password.placeholder = "password".localized
        password.returnKeyType = UIReturnKeyType.default
        password.addTarget(self, action: #selector(editingEnded), for: .editingChanged)
        return password
    }()
    
    lazy var logIn: UIButton = {
        let logIn = UIButton()
        logIn.toAutoLayout()
        logIn.layer.cornerRadius = 10
        logIn.clipsToBounds = true
		logIn.setTitle("enter".localized, for: .normal)
        logIn.titleLabel?.textColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        logIn.layer.shadowColor = UIColor.black.cgColor
        logIn.layer.shadowOffset = CGSize(width: 4, height: 4)
        logIn.layer.shadowOpacity = 0.7
        logIn.layer.shadowRadius = 4
        logIn.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        logIn.isEnabled = false
                
        if let image = UIImage(named: "blue_pixel") {
            logIn.imageView?.contentMode = .scaleAspectFill
            logIn.setBackgroundImage(image.imageWithAlpha(alpha: 1), for: .normal)
            logIn.setBackgroundImage(image.imageWithAlpha(alpha: 0.6), for: .selected)
            logIn.setBackgroundImage(image.imageWithAlpha(alpha: 0.6), for: .highlighted)
            logIn.setBackgroundImage(image.imageWithAlpha(alpha: 0.2), for: .disabled)
        }
        return logIn
    }()
    
    lazy var regIn: UIButton = {
        let regIn = UIButton()
        regIn.toAutoLayout()
        regIn.layer.cornerRadius = 10
        regIn.clipsToBounds = true
		regIn.setTitle("registration".localized, for: .normal)
        regIn.titleLabel?.textColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        regIn.layer.shadowColor = UIColor.black.cgColor
        regIn.layer.shadowOffset = CGSize(width: 4, height: 4)
        regIn.layer.shadowOpacity = 0.7
        regIn.layer.shadowRadius = 4
        regIn.addTarget(self, action: #selector(registerIn), for: .touchUpInside)
        regIn.isEnabled = false
                
        if let image = UIImage(named: "blue_pixel") {
            regIn.imageView?.contentMode = .scaleAspectFill
            regIn.setBackgroundImage(image.imageWithAlpha(alpha: 1), for: .normal)
            regIn.setBackgroundImage(image.imageWithAlpha(alpha: 0.6), for: .selected)
            regIn.setBackgroundImage(image.imageWithAlpha(alpha: 0.6), for: .highlighted)
            regIn.setBackgroundImage(image.imageWithAlpha(alpha: 0.2), for: .disabled)
        }
        return regIn
    }()
	
	lazy var biometricLogIn: UIButton = {
		let biometricLogIn = UIButton()
		biometricLogIn.toAutoLayout()
		biometricLogIn.layer.cornerRadius = 10
		biometricLogIn.clipsToBounds = true
		biometricLogIn.isHidden = true
		biometricLogIn.setTitle("touchID".localized, for: .normal)
		biometricLogIn.titleLabel?.textColor = UIColor.createColor(lightMode: .white, darkMode: .black)
		biometricLogIn.layer.shadowColor = UIColor.black.cgColor
		biometricLogIn.layer.shadowOffset = CGSize(width: 4, height: 4)
		biometricLogIn.layer.shadowOpacity = 0.7
		biometricLogIn.layer.shadowRadius = 4
		biometricLogIn.addTarget(self, action: #selector(useBiometric), for: .touchUpInside)
				
		if let image = UIImage(named: "blue_pixel") {
			biometricLogIn.imageView?.contentMode = .scaleAspectFill
			biometricLogIn.setBackgroundImage(image.imageWithAlpha(alpha: 1), for: .normal)
			biometricLogIn.setBackgroundImage(image.imageWithAlpha(alpha: 0.6), for: .selected)
			biometricLogIn.setBackgroundImage(image.imageWithAlpha(alpha: 0.6), for: .highlighted)
			biometricLogIn.setBackgroundImage(image.imageWithAlpha(alpha: 0.2), for: .disabled)
		}
		return biometricLogIn
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
       
    var queue: DispatchQueue? = nil
	let localAithorizationService = LocalAuthorizationService()
    
    init(callback: @escaping (_ authenticationData: (userService: UserService, name: String)) -> Void) {
        self.callback = callback
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        view.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .darkGray)
        scrollView.contentSize = CGSize(width: view.frame.width, height: max(view.frame.width, view.frame.height))
        
        contentView.addSubviews(logo, stackView, logIn, regIn, biometricLogIn)
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
        userName.text = "lazarev_es@sima-land.ru"
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
        
        if let delegate = delegate {
			let callback: (User)->Void = { [weak self] user in
				self?.userName.text = user.name
				if self?.localAithorizationService.canUseBiometricalAuthentication() ?? false {
					DispatchQueue.main.async {
						
						if self?.localAithorizationService.isFaceID() ?? false {
							self?.biometricLogIn.setTitle("faceID".localized, for: .normal)
						}
						self?.biometricLogIn.isHidden = false
					}
				}
			}
            _ = delegate.checkUserToDataBase(callback: callback, failureCallback: nil)
        }
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
                                     logIn.widthAnchor.constraint(equalToConstant: view.frame.width / 2 -  Const.leadingMargin),
                                     logIn.heightAnchor.constraint(equalToConstant: Const.size),
                                     
                                     regIn.topAnchor.constraint(equalTo: password.bottomAnchor, constant: Const.indent),
                                     regIn.leadingAnchor.constraint(equalTo: logIn.trailingAnchor, constant: Const.leadingMargin),
									 regIn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Const.trailingMargin),
                                     regIn.heightAnchor.constraint(equalToConstant: Const.size),
									 
									 biometricLogIn.topAnchor.constraint(equalTo: logIn.bottomAnchor, constant: Const.indent),
									 biometricLogIn.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
									 biometricLogIn.widthAnchor.constraint(equalToConstant: view.frame.width / 2 -  Const.leadingMargin),
									 biometricLogIn.heightAnchor.constraint(equalToConstant: Const.size)
									])
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardRectangle = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardRectangle.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardRectangle.height, right: 0)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    @objc func tap() {
        password.resignFirstResponder()
        userName.resignFirstResponder()
    }
    
    @objc func editingEnded() {
        regIn.isEnabled = self.userName.text != "" && self.password.text != ""
        logIn.isEnabled = regIn.isEnabled
    }
	
	@objc func useBiometric() {
		
		localAithorizationService.useBiometricalAuthentication {[weak self] result in
			if result {
				DispatchQueue.main.async {
					self?.logined()
				}
			}
		}
	}
    
    func logined() {
        let userService = CurrentUserService(name: userName.text ?? "", avatar: "avatar", status: "В ожидании еды")
        callback((userService: userService, name: userName.text ?? ""))
    }
    
    @objc func signIn() {
        if let delegate = delegate {
            let userName = self.userName.text ?? ""
            let password = self.password.text ?? ""
            
            DispatchQueue.global().async {
                delegate.signIn(login: userName, password: password) { (result, message) in
                    switch result {
                    case .success(true) :
                        DispatchQueue.main.async {
                            self.logined()
                        }
                    case .success(false):
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Ошибка авторизации", message: message, preferredStyle: .alert)
							let action = UIAlertAction(title: "agree".localized, style: .default, handler: nil)
                            alertController.addAction(action)
                            self.present(alertController, animated: true, completion: nil)
                        }
                        
                    case .failure(.unauthorized):
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Ошибка авторизации", message: message, preferredStyle: .alert)
							let action = UIAlertAction(title: "agree".localized, style: .default, handler: nil)
                            alertController.addAction(action)
                            self.present(alertController, animated: true, completion: nil)
                        }
                    default:
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Ошибка авторизации", message: "Критическая ошибка авторизации, попробуйте перезапустить приложение", preferredStyle: .alert)
							let action = UIAlertAction(title: "agree".localized, style: .default, handler: nil)
                            alertController.addAction(action)
                            self.present(alertController, animated: true) { fatalError() }
                            
                        }
                    }
                }
            }
        }
    }
    
    @objc func registerIn() {
        
        if let delegate = delegate {
            let userName = self.userName.text ?? ""
            let password = self.password.text ?? ""
            
            DispatchQueue.global().async {
                delegate.registerIn(login: userName, password: password) { result, message in
                    switch result {
                    case .success(true) :
                        DispatchQueue.main.async {
                            self.logined()
                        }
                    case .success(false):
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Ошибка авторизации", message: message, preferredStyle: .alert)
							let action = UIAlertAction(title: "agree".localized, style: .default, handler: nil)
                            alertController.addAction(action)
                            self.present(alertController, animated: true, completion: nil)
                        }
                        
                    case .failure(.unauthorized):
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Ошибка авторизации", message: message, preferredStyle: .alert)
							let action = UIAlertAction(title: "agree".localized, style: .default, handler: nil)
                            alertController.addAction(action)
                            self.present(alertController, animated: true, completion: nil)
                        }
                    default:
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Ошибка авторизации", message: "Критическая ошибка авторизации, попробуйте перезапустить приложение", preferredStyle: .alert)
							let action = UIAlertAction(title: "agree".localized, style: .default, handler: nil)
                            alertController.addAction(action)
                            self.present(alertController, animated: true) { fatalError() }
                            
                        }
                    }
                }
            }
        }
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
