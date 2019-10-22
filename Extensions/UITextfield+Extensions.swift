//
//  UITextfield+Extensions.swift
//  GithubIssue
//
//  Created by nhat on 10/20/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func setLeftPadding(_ amount: CGFloat = 10) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0,
                                               width: amount,
                                               height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPadding(_ amount: CGFloat = 10) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0,
                                               width: amount,
                                               height: self.frame.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func setPadding(_ amount: CGFloat = 10) {
        setLeftPadding(amount)
        setRightPadding(amount)
    }
    
    func addUnderline(_ width: CGFloat = 1.0, color: UIColor = .lightGray) {
        let border = CALayer()
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,
                              width:  self.frame.size.width,
                              height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
