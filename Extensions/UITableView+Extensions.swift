//
//  UITableView+Extensions.swift
//  GithubIssue
//
//  Created by nhat on 10/18/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func removeBottomSeperatorLine() {
        self.tableFooterView = UIView()
    }
}
