//
//  AuthenticationNetwork.swift
//  GithubIssue
//
//  Created by nhat on 10/20/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import Foundation
import Apollo

final class AuthenticationNetwork {
    
    let network: ApolloNetwork
    
    init(network: ApolloNetwork = ApolloNetwork()) {
        self.network = network
    }
    
    func authenticationWith(ownerName: String,
                            repositoryName: String,
                            completionHandler: @escaping (Result<Repository, Error>) -> Void) {
        
        let query = AuthenticateQuery(owner: ownerName, name: repositoryName)
        network.client.fetch(query: query,
                             cachePolicy: CachePolicy.fetchIgnoringCacheData) { (result) in
                                switch result {
                                case .success(let response):
                                    
                                    if let errors = response.errors {
                                        if let error = errors.first {
                                            // Show only first error
                                            completionHandler(.failure(error))
                                        }
                                    } else {
                                        guard let data = response.data, let repository = data.repository else {                                            
                                            completionHandler(.failure(CustomError.emptyData))
                                            return
                                        }
                                        
                                        completionHandler(.success(repository))
                                    }
                                case .failure(let error):
                                    completionHandler(.failure(error))
                                }
        }
    }
}
