//
//  Constants.swift
//  GithubIssue
//
//  Created by nhat on 10/19/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import Foundation

enum Constants {
    static var baseURL: URL {
        guard let url = URL(string: "https://api.github.com/graphql") else {
            fatalError("Base URL is invalid")
        }
        
        return url
    }
}

