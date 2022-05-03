//
//  ViewElements.swift
//  Navigation
//
//  Created by Егор Лазарев on 03.05.2022.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    var action: ((_ vc: UIViewController, _ sender: CustomButton) -> ())? = nil
    weak var vc: UIViewController?
    var textFieldArray = [UITextField]()
    var notification: (()->())? = nil {
        didSet {
            if let clouser = notification {
                clouser()
                notification = nil
            }
        }
    }
    
    init(vc: UIViewController,
         text:String?, backgroundColor:
         UIColor?, backgroundImage:
         UIImage?,
         tag: Int?,
         shadow: Bool,
         tapAction: ((_ vc: UIViewController, _ sender: CustomButton)->())?) {
       
        self.vc = vc
        
        super.init(frame: CGRect.zero)
        
        self.toAutoLayout()
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        if let title = text {
            self.setTitle(title, for: .normal)
            self.titleLabel?.textColor = .white
        }
        
        if let backColor = backgroundColor {
            self.backgroundColor = backColor
        }
        
        if let backImage = backgroundImage {
            self.setImage(backImage, for: .normal)
            self.imageView?.contentMode = .scaleAspectFill
        }
        
        if let action = tapAction {
            self.action = action
        }
        
        if let selfTag = tag {
            self.tag = selfTag
        }
        
        if shadow {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = CGSize(width: 4, height: 4)
            self.layer.shadowOpacity = 0.7
            self.layer.shadowRadius = 4
        }
        
        self.addTarget(self, action: #selector(tapActions), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapActions() {
        if let action = self.action, let selfVC = vc {
            action(selfVC, self)
        }
    }
    
    public func addTextField(textField: UITextField) {
         textFieldArray.append(textField)
     }
     
     public func removeTextField(textField: UITextField) {
         textFieldArray.removeAll(where: { $0 == textField})
     }
     
    
}
