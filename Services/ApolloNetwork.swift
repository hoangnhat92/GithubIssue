//
//  ApolloNetwork.swift
//  GithubIssue
//
//  Created by nhat on 10/19/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import Foundation
import Apollo

class ApolloNetwork {
    
    static let shared = ApolloNetwork()
    
    var accessToken: AccessToken?
    
    init(accessToken: AccessToken? = AuthenticationResult.shared.accessToken) {
        self.accessToken = accessToken
    }
    
    private lazy var networkTransport = HTTPNetworkTransport(
        url: Constants.baseURL,
        delegate: self
    )
    
    private lazy var client = ApolloClient(networkTransport: self.networkTransport)
}

extension ApolloNetwork: HTTPNetworkTransportPreflightDelegate {
    
    func networkTransport(_ networkTransport: HTTPNetworkTransport,
                          shouldSend request: URLRequest) -> Bool {
        // If there's an authenticated user, send the request. If not, don't.
        guard let _ = accessToken else { return false }
        
        return true
    }
    
    func networkTransport(_ networkTransport: HTTPNetworkTransport,
                          willSend request: inout URLRequest) {
        guard let token = accessToken else { return }
        // Get the existing headers, or create new ones if they're nil
        var headers = request.allHTTPHeaderFields ?? [String: String]()
        
        // Add any new headers you need
        headers["Authorization"] = "Bearer \(token.tokenString)"
        
        // Re-assign the updated headers to the request.
        request.allHTTPHeaderFields = headers
    }
}

extension ApolloNetwork {
        
    func authenticationWith(ownerName: String,
                            repository: String,
                            completionHandler: @escaping (Error?) -> Void) {
        let query = AuthenticateQuery(owner: ownerName, name: repository)
        client.fetch(query: query,
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
