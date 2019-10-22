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
                                                
                                                guard let edges = comment.comments.nodes else {
                                                    self.delegate?.performAction(.didFail(CustomError.emptyData))
                                                    return
                                                }
                                                
                                                let comments = edges.compactMap({ $0?.fragments.commentDetail })
                                                self.listComment = comments
                                                
                                                self.delegate?.performAction(.didFetch)
                                                
                                            case .failure(let error):
                                                self.delegate?.performAction(.didFail(error))
                                            }
        }
    }
    
    func loadMoreListComment() {
        guard
            let commentIssue = commentIssue,
            let endCursor  = commentIssue.comments.pageInfo.endCursor else { return }
        repositoryNetwork.loadMoreListComment(ownerName: issueDetail.repository.owner.login,
                                              repositoryName: issueDetail.repository.name,
                                              number: issueDetail.number,
                                              limit: Constants.limit,
                                              cursor: endCursor) {
                                                [weak self] (result) in
                                                guard let self = self else { return }
                                                
                                                switch result {
                                                case .success(let comment):
                                                    self.commentIssue = comment
                                                    
                                                    guard let edges = comment.comments.nodes else {
                                                        self.delegate?.performAction(.didFail(CustomError.emptyData))
                                                        return
                                                    }
                                                    
                                                    let comments = edges.compactMap({ $0?.fragments.commentDetail })
                                                    self.listComment += comments
                                                    self.delegate?.performAction(.didLoadMore)
                                                    
                                                case .failure(let error):
                                                    self.delegate?.performAction(.didFail(error))
                                                }
        }
    }
    
    func watchListComment() {
        repositoryNetwork.watchListComment(ownerName: issueDetail.repository.owner.login,
                                           repositoryName: issueDetail.repository.name,
                                           number: issueDetail.number,
                                           limit: Constants.limit) {
                                            [weak self] (result) in
                                            guard let self = self else { return }
                                                                                        
                                            switch result {
                                            case .success(let comment):
                                                self.commentIssue = comment
                                                
                                                guard let edges = comment.comments.nodes else {
                                                    self.delegate?.performAction(.didFail(CustomError.emptyData))
                                                    return
                                                }
                                                
                                                let comments = edges.compactMap({ $0?.fragments.commentDetail })
                                                self.listComment = comments
                                                self.delegate?.performAction(.didFetch)
                                                
                                            case .failure(let error):
                                                self.delegate?.performAction(.didFail(error))
                                            }
        }
    }
    
    func closeIssue() {
        repositoryNetwork.closeIssue(id: issueDetail.id) {
            [weak self] (error) in
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.performAction(.didFail(error))
            } else {
                self.delegate?.performAction(.didCloseIssue)
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
    
    func shouldShowCloseIssueButton() -> Bool {
        return (issueDetail.state != .closed)
    }
    
    func shouldLoadMoreData(_ indexPath: IndexPath) -> Bool {
        guard let commentIssue = commentIssue else { return false }
        
        if indexPath.row == listComment.count - 1 {
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
    
    func addCommentToIssue(_ text: String) {
        commentNetwork.addCommentIssue(subjectID: issueDetail.id, bodyString: text) {
            [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let commentDetail):
                self.listComment.append(commentDetail)
                self.delegate?.performAction(.didAddComment)
            case .failure(let error):
                debugPrint(error)
                self.delegate?.performAction(.didFail(error))
            }
        }
    }
    
    func deleteComment(_ commentId: String) {
        commentNetwork.deleteCommentIssue(subjectID: commentId) { (result) in
            switch result {
            case .success(let id):
                self.listComment.removeAll(where: { $0.id == id })
                self.delegate?.performAction(.didDeleteComment)
            case .failure(let error):
                self.delegate?.performAction(.didFail(error))
            }
        }
    }
    
    func editComment(_ commentId: String, text: String) {
        commentNetwork.editCommentIssue(subjectID: commentId, bodyString: text) { (error) in
            if let error = error {
                self.delegate?.performAction(.didFail(error))
            } else {
                self.delegate?.performAction(.didEditComment)
            }
        }
    }
}

// MARK: - Configurations
extension DetailIssueViewModel {
    enum Constants {
        static let limit: Int = 5
    }
    
    enum Action {
        case didCloseIssue
        case didEditComment
        case didAddComment
        case didDeleteComment
        case didFetch
        case didLoadMore
        case didFail(Error)
    }
}
