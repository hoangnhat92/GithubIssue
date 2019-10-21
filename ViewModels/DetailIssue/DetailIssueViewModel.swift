//
//  DetailIssueViewModel.swift
//  GithubIssue
//
//  Created by nhat on 10/21/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import Foundation

protocol DetailIssueViewModelDelegate: class {
    func performAction(_ action: DetailIssueViewModel.Action)
}

class DetailIssueViewModel {
    
    // MARK: - Attributes
    weak var delegate: DetailIssueViewModelDelegate?
    
    private let repositoryNetwork: RepositoryNetwork
    
    private let commentNetwork: CommentNetwork
    
    private let issueDetail: IssueDetail
    
    private var commentIssue: CommentIssue?
    
    private var listComment: [CommentDetail] = []
    
    // MARK: - Initializers
    
    init(repositoryNetwork: RepositoryNetwork = RepositoryNetwork(),
         commentNetwork: CommentNetwork = CommentNetwork(),
         issueDetail: IssueDetail) {
        self.repositoryNetwork = repositoryNetwork
        self.commentNetwork = commentNetwork
        self.issueDetail = issueDetail
    }
    
    // MARK: - Fetch API
    
    func getListComment() {
        repositoryNetwork.getListComment(ownerName: issueDetail.repository.owner.login,
                               repositoryName: issueDetail.repository.name,
                               number: issueDetail.number,
                               limit: Constants.limit) {
                                [weak self] (result) in
                                guard let self = self else { return }
                                
                                switch result {
                                case .success(let comment):
                                    self.commentIssue = comment
                                    
                                    guard let edges = comment.comments.edges else {
                                        self.delegate?.performAction(.didFail(CustomError.emptyData))
                                        return
                                    }
                                    
                                    let comments = edges.compactMap({ $0?.node?.fragments.commentDetail })
                                    self.listComment = comments
                                    
                                    self.delegate?.performAction(.didFetch)
                                    
                                case .failure(let error):
                                    self.delegate?.performAction(.didFail(error))
                                }
        }
    }
    
    func loadMoreListComment() {
        repositoryNetwork.getListComment(ownerName: issueDetail.repository.owner.login,
                               repositoryName: issueDetail.repository.name,
                               number: issueDetail.number,
                               limit: Constants.limit,
                               cursor: commentIssue?.comments.pageInfo.endCursor) {
                                [weak self] (result) in
                                guard let self = self else { return }
                                
                                switch result {
                                case .success(let comment):
                                    self.commentIssue = comment
                                    
                                    guard let edges = comment.comments.edges else {
                                        self.delegate?.performAction(.didFail(CustomError.emptyData))
                                        return
                                    }
                                    
                                    let comments = edges.compactMap({ $0?.node?.fragments.commentDetail })
                                    self.listComment += comments
                                    
                                    self.delegate?.performAction(.didFetch)
                                case .failure(let error):
                                    self.delegate?.performAction(.didFail(error))
                                }
        }
    }
    
    // MARK: - Functions
    func getHeaderDetailIssue() -> HeaderDetailissueViewModel? {
        guard let commentIssue = commentIssue else { return nil }
        
        let issueDetail = commentIssue.fragments.issueDetail
        return HeaderDetailissueViewModel(title: issueDetail.title,
                                          body: issueDetail.bodyText)
    }
    
    
    func shouldLoadMoreData(_ indexPath: IndexPath) -> Bool {
        guard
            let commentIssue = commentIssue,
            let edges = commentIssue.comments.edges else {
                return false
        }
        
        if indexPath.row == edges.count - 1 {
            return commentIssue.comments.pageInfo.hasNextPage
        }
        
        return false
    }
    
    func numberOfItemInSections(_ section: Int) -> Int {
        return listComment.count
    }
    
    func itemForIndexPath(_ indexPath: IndexPath) -> CommentDetail? {
        guard indexPath.row < listComment.count else { return nil }
        
        return listComment[indexPath.row]
    }
}

// MARK: - Configurations
extension DetailIssueViewModel {
    enum Constants {
        static let limit: Int = 5
    }
    
    enum Action {
        case didFetch
        case didLoadMore
        case didFail(Error)
    }
}
