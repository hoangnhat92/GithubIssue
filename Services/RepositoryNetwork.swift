//
//  RepositoryNetwork.swift
//  GithubIssue
//
//  Created by nhat on 10/20/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import Foundation
import Apollo

final class RepositoryNetwork {
    
    let network: ApolloNetwork
    
    init(network: ApolloNetwork = ApolloNetwork()) {
        self.network = network
    }
    
    func getListIssue(ownerName: String,
                            repository: String,
                            completionHandler: @escaping (Error?) -> Void) {
        let query = AuthenticateQuery(owner: ownerName, name: repository)
        network.client.fetch(query: query,
                     cachePolicy: CachePolicy.fetchIgnoringCacheData) { (result) in
                        switch result {
                        case .success(let data):
                            if let errors = data.errors {
                                completionHandler(errors.first)
                            } else {
                                completionHandler(nil)
                            }
                        case .failure(let error):
                            completionHandler(error)
                        }
        }
    }
    
}
