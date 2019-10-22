//
//  UIViewController+Extensions.swift
//  GithubIssue
//
//  Created by nhat on 10/19/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {
    
    func showLoading(_ animated: Bool = true) {
        MBProgressHUD.showAdded(to: self.view, animated: animated)
    }
    
    func hideLoading(_ animated: Bool = true) {
        MBProgressHUD.hide(for: self.view, animated: animated)
    }
    
}
