//
//  Fonts.swift
//  GithubIssue
//
//  Created by nhat on 10/22/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import UIKit

enum Font: String {
    case regular = "HelveticaNeue"
    case bold = "HelveticaNeue-Bold"
    case medium = "HelveticaNeue-Medium"
}

extension Font {
    
    func size(_ size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    var largeTitle: UIFont { return size(24) }
    
    var title: UIFont { return size(18) }
    
    var subttile: UIFont { return size(15) }

    var normal: UIFont { return size(14) }
    
    var small: UIFont { return size(12) }
}
