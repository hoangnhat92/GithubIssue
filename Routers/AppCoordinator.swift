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
    
    lazy var navigationController: UINavigationController = {
        let navigation = UINavigationController()
        navigation.setDarkBackground()
        navigation.hideBottomBar()
        navigation.navigationBar.tintColor = .white
        return navigation
    }()
    
    // MARK: - Initializers
    
    init(window: UIWindow?) {
        self.window = window
        setupNotifications()
    }
    
    fileprivate func setupNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleUnauthorizeAccessToken),
                                               name: .didUnauthorizeAccessToken,
                                               object: nil)
    }
    
    // MARK: - Functions
    
    func start() {
        goToAuthentication()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func goToListIssue(with repository: Repository) {
        let listIssue = ListIssueCoordinator(navigation: navigationController,
                                             repository: repository)
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
    func didFinishAuthentication(_ coordinator: AuthenticationCoordinator, _ repository: Repository) {
        remove(coordinator: coordinator)
        goToListIssue(with: repository)
    }
}

extension AppCoordinator {
    @objc fileprivate func handleUnauthorizeAccessToken() {
        // Clear all coordinators
        childCoordinators.removeAll()
        // Setup new authentication
        goToAuthentication()
    }
}
