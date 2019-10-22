//
//  UIButton+Extensions.swift
//  GithubIssue
//
//  Created by nhat on 10/22/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import UIKit

extension UIButton {
    
    func addBorder(radius radius: CGFloat = 10,
                   color: UIColor = .clear,
                   width: CGFloat = 1.0) {
        layer.cornerRadius = radius
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.masksToBounds = true
    }
    
}
