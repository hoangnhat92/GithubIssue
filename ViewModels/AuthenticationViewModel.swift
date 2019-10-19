//
//  AuthenticationViewModel.swift
//  GithubIssue
//
//  Created by nhat on 10/19/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import Foundation

protocol AuthenticationViewModelDelegate: class {
    func didLoginSuccessfully()
    func didLoginFailed(_ error: Error)
}

class AuthenticationViewModel {
    
    // MARK: - Attributes
    weak var delegate: AuthenticationViewModelDelegate?
    private let network: ApolloNetwork
    
    // MARK: - Initializers
    
    init(network: ApolloNetwork = ApolloNetwork()) {
        self.network = network
    }
    
    // MARK: - Functions
    
    func loginWith(owner: String, repositiory: String, token: String) {
        network.accessToken = AccessToken(tokenString: token)
        network.authenticationWith(ownerName: owner, repository: repositiory) {
            [weak self] (error) in
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.didLoginFailed(error)
            }else{
                // Save access token after login successfully
                AuthenticationResult.shared.accessToken = self.network.accessToken
                
                self.delegate?.didLoginSuccessfully()
            }
        }
    }
    
}
