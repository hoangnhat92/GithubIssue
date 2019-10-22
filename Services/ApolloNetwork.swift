//
//  ApolloNetwork.swift
//  GithubIssue
//
//  Created by nhat on 10/19/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import Foundation
import Apollo

final class ApolloNetwork {
    
    // MARK: - Attributes
    static let shared = ApolloNetwork()
    
    lazy var networkTransport = HTTPNetworkTransport(
        url: Constants.baseURL,
        delegate: self
    )
    
    lazy var client: ApolloClient = {
        let cl = ApolloClient(networkTransport: self.networkTransport)
        cl.cacheKeyForObject = { $0["id"] }
        return cl
    }()
    
    var accessToken: AccessToken?
    
    // MARK: - Initializers
    
    init(accessToken: AccessToken? = AuthenticationResult.shared.accessToken) {
        self.accessToken = accessToken
    }
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
    
    func networkTransport(_ networkTransport: HTTPNetworkTransport,
                          didCompleteRawTaskForRequest request: URLRequest,
                          withData data: Data?,
                          response: URLResponse?,
                          error: Error?) {
        
        if let error = error {
          debugPrint(error)
        }
    }
}
