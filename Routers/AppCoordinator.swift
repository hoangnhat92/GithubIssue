//
//  AppCoordinator.swift
//  GithubIssue
//
//  Created by nhat on 10/17/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: - Attributes
              
    var window: UIWindow?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController = UINavigationController()
    
    // MARK: - Initializers
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    // MARK: - Functions
    
    func start() {
        goToAuthentication()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func goToListIssue() {
        let listIssue = ListIssueCoordinator(navigation: navigationController)
        add(coordinator: listIssue)
        listIssue.start()
    }
        
    fileprivate func goToAuthentication() {
        let auth = AuthenticationCoordinator(navigation: navigationController)
        auth.delegate = self
        add(coordinator: auth)                
        auth.start()
    }
}

// MARK: Extensions

extension AppCoordinator: AuthenticationCoordinatorDelegate {
    func didFinishAuthentication(_ coordinator: AuthenticationCoordinator) {
        remove(coordinator: coordinator)
        goToListIssue()
    }
}
