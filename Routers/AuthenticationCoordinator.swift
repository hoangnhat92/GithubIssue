//
//  AuthicationCoordinator.swift
//  GithubIssue
//
//  Created by nhat on 10/17/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import Foundation
import UIKit

class AuthenticationCoordinator: Coordinator {
    
    // MARK: - Attributes
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController

    // MARK: - Initializers
    
    init(navigation: UINavigationController) {
        self.navigationController = navigation
    }
    
    // MARK: - Functions
    
    func start() {
        let auth = AuthenticationViewController(nibName: nil, bundle: nil)
        navigationController.viewControllers = [auth]
    }
}
