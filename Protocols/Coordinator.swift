//
//  Coordinator.swift
//  GithubIssue
//
//  Created by nhat on 10/17/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

extension Coordinator {

    func add(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func remove(coordinator: Coordinator) {        
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }

}
