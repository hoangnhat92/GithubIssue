//
//  AuthenticationViewModel.swift
//  GithubIssue
//
//  Created by nhat on 10/19/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import Foundation

typealias Repository = AuthenticateQuery.Data.Repository

protocol AuthenticationViewModelDelegate: class {
    func didLoginSuccessfully(with repository: Repository)
    func didLoginFailed(_ error: Error)
}

final class AuthenticationViewModel {
    
    // MARK: - Attributes
    weak var delegate: AuthenticationViewModelDelegate?
    
    private let network: AuthenticationNetwork
    
    // MARK: - Initializers
    
    init(network: AuthenticationNetwork = AuthenticationNetwork()) {
        self.network = network
    }
    
    // MARK: - Functions
    
    func loginWith(owner: String, repositiory: String, token: String) {
        network.network.accessToken = AccessToken(tokenString: token)
        network.authenticationWith(ownerName: owner, repositoryName: repositiory) {
            [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let repository):
                // Save access token after login successfully
                AuthenticationResult.shared.accessToken = self.network.network.accessToken
                
                self.delegate?.didLoginSuccessfully(with: repository)
            case .failure(let error):
                self.delegate?.didLoginFailed(error)
            }
        }
    }
}
