//
//  ListIssueViewModel.swift
//  GithubIssue
//
//  Created by nhat on 10/20/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import Foundation

typealias Issue = GetRepositoryQuery.Data.Repository.Issue

protocol ListIssueViewModelDelegate: class {
    func performAction(_ action: ListIssueViewModel.Action)
}

class ListIssueViewModel {
    
    // MARK: - Attributes
    weak var delegate: ListIssueViewModelDelegate?
    
    let repository: Repository
    
    let network: RepositoryNetwork
    
    var issue: Issue?
    
    var listIssue: [IssueDetail] = []
    
    // MARK: - Initializers
    
    init(repository: Repository,
         network: RepositoryNetwork = RepositoryNetwork()) {
        self.repository = repository
        self.network = network
    }
    
    
    // MARK: - Functions
    
    func getOwnerNameRepository() -> String {
        return repository.nameWithOwner
    }
    
    func getListIssue() {
        network.getListIssue(ownerName: repository.owner.login,
                             repositoryName: repository.name,
                             limit: Constants.limit) {
                                [weak self ](result) in
                                guard let self = self else { return }
                                
                                switch result {
                                case .success(let issue):
                                    self.issue = issue
                                    guard let edges = issue.edges else {
                                        self.delegate?.performAction(.didFail(CustomError.emptyData))
                                        return
                                    }
                                    
                                    let issues = edges.compactMap({ $0?.node?.fragments.issueDetail })
                                    self.listIssue = issues
                                    
                                    self.delegate?.performAction(.didFetch)
                                case .failure(let error):
                                    self.delegate?.performAction(.didFail(error))
                                }
        }
    }
    
    func loadMoreListIssue() {
        guard let issue = issue else { return }
        network.getListIssue(ownerName: repository.owner.login,
                             repositoryName: repository.name,
                             limit: Constants.limit,
                             cursor: issue.pageInfo.endCursor) {
                                [weak self ](result) in
                                guard let self = self else { return }
                                
                                switch result {
                                case .success(let issue):
                                    self.issue = issue
                                    guard let edges = issue.edges else {
                                        return
                                    }
                                    
                                    let issues = edges.compactMap({ $0?.node?.fragments.issueDetail })
                                    self.listIssue += issues
                                    
                                    self.delegate?.performAction(.didLoadMore)
                                    
                                case .failure(let error):
                                    self.delegate?.performAction(.didFail(error))
                                }
        }
    }
    
    func shouldLoadMoreData(_ indexPath: IndexPath) -> Bool {
        guard
            let issue = issue,
            let edges = issue.edges else {
                return false
        }
        
        if indexPath.row == edges.count - 1 {
            return issue.pageInfo.hasNextPage
        }
        
        return false
    }
    
    func numberOfItemInSections(_ section: Int) -> Int {
        return listIssue.count
    }
    
    func itemForIndexPath(_ indexPath: IndexPath) -> IssueDetail? {
        guard indexPath.row < listIssue.count else { return nil }
                
        return listIssue[indexPath.row]
    }
}

extension ListIssueViewModel {
    enum Constants {
        static let limit: Int = 5
    }
    
    enum Action {
        case didFetch
        case didLoadMore
        case didFail(Error)        
    }
}
