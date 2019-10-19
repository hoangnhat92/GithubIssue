//
//  AuthenticationResult.swift
//  GithubIssue
//
//  Created by nhat on 10/19/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import Foundation
import KeychainSwift

final public class AuthenticationResult {
    
    static let shared = AuthenticationResult()
    
    let keychain: KeychainSwift
    
    init(keychain: KeychainSwift = KeychainSwift()) {
        self.keychain = keychain
    }
    
    var accessToken: AccessToken? {
        set {
            guard
                let value = newValue,
                let encodedData = try? JSONEncoder().encode(value) else { return }
            
            keychain.set(encodedData, forKey: Constants.token.rawValue)
        }
        get {
            if let data = keychain.getData(Constants.token.rawValue) {
                let token = try? JSONDecoder().decode(AccessToken.self, from: data)
                return token
            }
            
            return nil
        }
    }
}

private extension AuthenticationResult {
    enum Constants: String {
        case token
    }
}
