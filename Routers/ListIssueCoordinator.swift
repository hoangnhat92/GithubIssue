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
    
    private var listIssueViewController: ListIssueViewController
    
    // MARK: - Initializers
    
    init(navigation: UINavigationController, repository: Repository) {
        self.navigationController = navigation
        self.repository = repository
        let viewModel = ListIssueViewModel(repository: repository)
        listIssueViewController = ListIssueViewController(viewModel: viewModel)
    }
    
    // MARK: - Functions
    
    func start() {
        listIssueViewController.delegate = self
        navigationController.setViewControllers([listIssueViewController], animated: true)        
    }
    
    func startDetailIssue(_ issue: IssueDetail) {
        let viewModel = DetailIssueViewModel(issueDetail: issue)
        let detailIssue = DetailIssueViewController(viewModel: viewModel)
        detailIssue.delegate = self
        navigationController.pushViewController(detailIssue, animated: true)
    }
}

extension ListIssueCoordinator: ListIssueViewControllerDelegate {
    func goToDetailIssue(_ issue: IssueDetail) {
        startDetailIssue(issue)
    }
}

extension ListIssueCoordinator: DetailIssueViewControllerDelegate {
    func didCloseIssue() {
        listIssueViewController.watchListLissue()
    }
}
