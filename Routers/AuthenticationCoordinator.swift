//
//  AuthicationCoordinator.swift
//  GithubIssue
//
//  Created by nhat on 10/17/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import Foundation
import UIKit

protocol AuthenticationCoordinatorDelegate: class {
    func didFinishAuthentication(_ coordinator: AuthenticationCoordinator)
}

class AuthenticationCoordinator: Coordinator {
    
    // MARK: - Attributes
    weak var delegate: AuthenticationCoordinatorDelegate?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController

    let authView: AuthenticationViewController
    
    // MARK: - Initializers
    
    init(navigation: UINavigationController) {
        self.navigationController = navigation
        self.authView = AuthenticationViewController()
        self.authView.delegate = self
    }
    
    // MARK: - Functions
    
    func start() {
        navigationController.setViewControllers([authView], animated: true)
    }
}

// MARK: - Extensions

extension AuthenticationCoordinator: AuthenticationDelegate {
    func didFinishAuthentication() {
        delegate?.didFinishAuthentication(self)
    }
}
