//
//  RepositoryNetwork.swift
//  GithubIssue
//
//  Created by nhat on 10/20/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import Foundation
import Apollo

typealias CommentIssue = GetListCommentsQuery.Data.Repository.Issue

final class RepositoryNetwork {
    
    let network: ApolloNetwork
    
    init(network: ApolloNetwork = ApolloNetwork()) {
        self.network = network
    }
    
    func getListIssue(ownerName: String,
                      repositoryName: String,
                      limit: Int,
                      cursor: String? = nil,
                      completionHandler: @escaping (Result<Issue, Error>) -> Void) {
        
        let query = GetRepositoryQuery(owner: ownerName,
                                       name: repositoryName,
                                       limit: limit,
                                       cursor: cursor)
        
        network.client.fetch(query: query) { (result) in
            switch result {
            case .success(let response):
                
                if let errors = response.errors {
                    if let first = errors.first {
                        completionHandler(.failure(first))
                    }
                } else {
                    guard
                        let data = response.data,
                        let repository = data.repository else {
                            completionHandler(.failure(CustomError.emptyData))
                            return
                    }
                    
                    let issue = repository.issues
                    completionHandler(.success(issue))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getListComment(ownerName: String,
                        repositoryName: String,
                        number: Int,
                        limit: Int,
                        cursor: String? = nil,
                        completionHandler: @escaping (Result<CommentIssue, Error>) -> Void) {
        
        let query = GetListCommentsQuery(owner: ownerName,
                                         name: repositoryName,
                                         number: number,
                                         limit: limit,
                                         cursor: cursor)
        
        network.client.fetch(query: query) { (result) in
            switch result {
            case .success(let response):
                
                if let errors = response.errors {
                    if let first = errors.first {
                        completionHandler(.failure(first))
                    }
                } else {
                    guard
                        let data = response.data,
                        let repository = data.repository,
                        let issue = repository.issue else {
                            completionHandler(.failure(CustomError.emptyData))
                            return
                    }
                                        
                    completionHandler(.success(issue))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
