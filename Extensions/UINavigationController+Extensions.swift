//
//  UINavigationController+Extensions.swift
//  GithubIssue
//
//  Created by nhat on 10/22/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func setDarkBackground() {
        navigationBar.barTintColor = UIColor.darkGray
        navigationBar.barStyle = .black
        navigationBar.isTranslucent = false
    }
    
    func hideBottomBar() {        
        navigationBar.setValue(true, forKey: Constants.Keys.hideShadow.rawValue)
    }
}

fileprivate extension UINavigationController {
    enum Constants {
        enum Keys: String {
            case hideShadow = "hidesShadow"
        }
    }
}
