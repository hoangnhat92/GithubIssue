//
//  ListIssueViewController.swift
//  GithubIssue
//
//  Created by nhat on 10/17/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import UIKit
import Reusable

final class ListIssueViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var tableView: UITableView =  {
        let tblView = UITableView()
        tblView.backgroundColor = .black
        tblView.separatorColor = .darkGray
        tblView.delegate = self
        tblView.dataSource = self
        return tblView
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        setupLayout()
    }
    
    // MARK: - Set up
    
    fileprivate func setupView() {
        
        title = "GitHub"
        
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .always
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
        
        view.addSubview(tableView)
        
        registerCells()
    }
    
    fileprivate func setupLayout() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    fileprivate func registerCells() {
        tableView.register(cellType: IssueTableViewCell.self)
    }
    
    // MARK: - IBActions
}


// MARK: - Extensions

extension ListIssueViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: IssueTableViewCell.self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}
