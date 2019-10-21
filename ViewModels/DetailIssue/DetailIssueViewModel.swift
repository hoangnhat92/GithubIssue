//
//  DetailIssueViewModel.swift
//  GithubIssue
//
//  Created by nhat on 10/21/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import Foundation

class DetailIssueViewModel {
    
    // MARK: - Attributes
    
    let network: RepositoryNetwork
    
    let issue: IssueDetail
    
    // MARK: - Initializers
    
    init(network: RepositoryNetwork = RepositoryNetwork(),
         issue: IssueDetail) {
        self.network = network
        self.issue = issue
    }
    
    // MARK: - Functions
    func getHeaderDetailIssue() -> HeaderDetailissueViewModel{
        return HeaderDetailissueViewModel(title: issue.title,
                                          body: issue.bodyText)
    }
    
}
