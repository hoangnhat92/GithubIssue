//
//  AuthenticationViewController.swift
//  GithubIssue
//
//  Created by nhat on 10/17/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import UIKit

final class AuthenticationViewController: UIViewController {

    // MARK: - Properties
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }        
    
    // MARK: - Set up
    fileprivate func setupView() {
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - IBActions
    
    // MARK: - Extensions
}
