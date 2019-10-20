//
//  Date+Extensions.swift
//  GithubIssue
//
//  Created by nhat on 10/20/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import Foundation
import SwiftDate

extension String {
    func timeAgo(_ locale: Locales = .english) -> String {
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from:self)!        
        let dateString = date.toRelative(style: RelativeFormatter.defaultStyle(),
                                         locale: Locales.english)
        return dateString
    }
}
