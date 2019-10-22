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
    
    // MARK: - Attributes
    
    let network: ApolloNetwork
    
    private var queryListCommentWatcher: GraphQLQueryWatcher<GetListCommentsQuery>?
    private var queryRepositoryWatcher: GraphQLQueryWatcher<GetRepositoryQuery>?
    
    // MARK: - Initializers
    
    init(network: ApolloNetwork = ApolloNetwork.shared) {
        self.network = network
    }        
    
    // MARK: - Functions
    
    func getListIssue(ownerName: String,
                      repositoryName: String,
                      limit: Int,
                      cursor: String? = nil,
                      completionHandler: @escaping (Result<Issue, Error>) -> Void) {
        
        let query = GetRepositoryQuery(owner: ownerName,
                                       name: repositoryName,
                                       limit: limit,
                                       cursor: cursor)
        
        // Always fetch data without cache when refresh
        let cachePolicy: CachePolicy = (cursor != nil) ? .returnCacheDataElseFetch : .fetchIgnoringCacheData
        
        queryRepositoryWatcher = network.client.watch(query: query,
                                                      cachePolicy: cachePolicy) { (result) in
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
        
        // Always fetch data without cache when refresh
        let cachePolicy: CachePolicy = (cursor != nil) ? .returnCacheDataElseFetch : .fetchIgnoringCacheData
        
        queryListCommentWatcher = network.client.watch(query: query,
                                                       cachePolicy: cachePolicy) { (result) in
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
