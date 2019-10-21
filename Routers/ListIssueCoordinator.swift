//
//  ListIssueCoordinator.swift
//  GithubIssue
//
//  Created by nhat on 10/17/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import Foundation
import UIKit

class ListIssueCoordinator: Coordinator {
    
    // MARK: - Attributes
    
    let repository: Repository
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    // MARK: - Initializers
    
    init(navigation: UINavigationController, repository: Repository) {
        self.navigationController = navigation
        self.repository = repository
    }
    
    // MARK: - Functions
    
    func start() {
        let viewModel = ListIssueViewModel(repository: repository)
        let listIssue = ListIssueViewController(viewModel: viewModel)
        listIssue.delegate = self
        navigationController.setViewControllers([listIssue], animated: true)        
    }
    
    func startDetailIssue(_ issue: IssueDetail) {
        let viewModel = DetailIssueViewModel(issue: issue)
        let detailIssue = DetailIssueViewController(viewModel: viewModel)
        navigationController.pushViewController(detailIssue, animated: true)
    }
}

extension ListIssueCoordinator: ListIssueViewControllerDelegate {
    func goToDetailIssue(_ issue: IssueDetail) {
        startDetailIssue(issue)
    }
}
