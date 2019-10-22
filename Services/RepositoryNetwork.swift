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
    
    private var queryCommentWatcher: GraphQLQueryWatcher<GetListCommentsQuery>?
    private var queryRepositoryWatcher: GraphQLQueryWatcher<GetRepositoryQuery>?
    
    // MARK: - Initializers
    
    init(network: ApolloNetwork = ApolloNetwork.shared) {
        self.network = network
    }        
    
    // MARK: - Functions
    
    func getListIssue(ownerName: String,
                      repositoryName: String,
                      states: [IssueState] = [],
                      limit: Int,
                      completionHandler: @escaping (Result<Issue, Error>) -> Void) {
        
        let query = GetRepositoryQuery(owner: ownerName,
                                       name: repositoryName,
                                       states: states,
                                       limit: limit)
        network.client.fetch(query: query,
                             cachePolicy: .fetchIgnoringCacheData) {
                                (result) in
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
    
    func loadMoreListIssue(ownerName: String,
                           repositoryName: String,
                           states: [IssueState] = [],
                           limit: Int,
                           cursor: String? = nil,
                           completionHandler: @escaping (Result<Issue, Error>) -> Void) {
        
        let query = GetRepositoryQuery(owner: ownerName,
                                       name: repositoryName,
                                       states: states,
                                       limit: limit,
                                       cursor: cursor)
        network.client.fetch(query: query) {
            (result) in
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
    
    func watchListIssue(ownerName: String,
                        repositoryName: String,
                        states: [IssueState] = [],
                        limit: Int,
                        completionHandler: @escaping (Result<Issue, Error>) -> Void) {
        
        let query = GetRepositoryQuery(owner: ownerName,
                                       name: repositoryName,
                                       states: states,
                                       limit: limit)
        queryRepositoryWatcher = network.client.watch(query: query,
                                                      cachePolicy: .fetchIgnoringCacheData) {
                                                        [weak self] (result) in
                                                        guard let self = self else { return }
                                                        self.queryRepositoryWatcher?.cancel()
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
    
    func closeIssue(id: String, completionHandler: @escaping (Error?) -> Void) {
        let mutation = CloseIssueMutation(id: id)
        
        network.client.perform(mutation: mutation) { (result) in
            switch result {
            case .success:
                completionHandler(nil)
            case .failure(let error):
                completionHandler(error)
            }
        }
    }
    
    func getListComment(ownerName: String,
                        repositoryName: String,
                        number: Int,
                        limit: Int,
                        completionHandler: @escaping (Result<CommentIssue, Error>) -> Void) {
        
        let query = GetListCommentsQuery(owner: ownerName,
                                         name: repositoryName,
                                         number: number,
                                         limit: limit)
        
        network.client.fetch(query: query,
                             cachePolicy: .fetchIgnoringCacheData) {
                                (result) in
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
    
    func loadMoreListComment(ownerName: String,
                             repositoryName: String,
                             number: Int,
                             limit: Int,
                             cursor: String,
                             completionHandler: @escaping (Result<CommentIssue, Error>) -> Void) {
        
        let query = GetListCommentsQuery(owner: ownerName,
                                         name: repositoryName,
                                         number: number,
                                         limit: limit,
                                         cursor: cursor)
        
        network.client.fetch(query: query) {
            (result) in
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
    
    func watchListComment(ownerName: String,
                          repositoryName: String,
                          number: Int,
                          limit: Int,
                          completionHandler: @escaping (Result<CommentIssue, Error>) -> Void) {
        
        let query = GetListCommentsQuery(owner: ownerName,
                                         name: repositoryName,
                                         number: number,
                                         limit: limit)
        
        queryCommentWatcher = network.client.watch(query: query) {
            [weak self] (result) in
            guard let self = self else { return }
            self.queryCommentWatcher?.cancel()
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
