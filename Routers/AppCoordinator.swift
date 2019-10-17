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
        
    var window: UIWindow?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController = UINavigationController()
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        goToAuthentication()
        self.window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
        
    fileprivate func goToAuthentication() {
        let auth = AuthenticationCoordinator(navigation: navigationController)
        add(coordinator: auth)
        auth.start()
    }
}
