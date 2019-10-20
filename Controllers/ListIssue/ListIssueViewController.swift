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
    
    let viewModel: ListIssueViewModel
    
    var issues: [IssueDetail]?
    
    private lazy var tableView: UITableView =  {
        let tblView = UITableView()
        tblView.backgroundColor = .black
        tblView.separatorColor = .darkGray
        
        tblView.delegate = self
        tblView.dataSource = self
        return tblView
    }()
    
    // MARK: - Initialize
    
    init(viewModel: ListIssueViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        setupLayout()
        setupViewModel()
        registerCells()
        setupHeaderTableView()
        loadData()
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
        tableView.removeBottomSeperatorLine()
    }
    
    fileprivate func setupLayout() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    fileprivate func registerCells() {
        tableView.register(cellType: IssueTableViewCell.self)
    }
    
    fileprivate func setupHeaderTableView() {
        let view = UIView(frame: CGRect(x: 0, y: 0,
                                        width: self.view.frame.size.width,
                                        height: 40))
        let label = UILabel()
        label.textColor = .black
        label.text = viewModel.getOwnerNameRepository()
        view.backgroundColor = .white
        view.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.edges.equalTo(view).inset(5)
        }
        
        tableView.tableHeaderView = view
    }
    
    fileprivate func setupViewModel() {
        viewModel.delegate = self
    }
    
    fileprivate func loadData() {
        showLoading()
        viewModel.getListIssue()
    }
    
    // MARK: - IBActions
}


// MARK: - Extensions

extension ListIssueViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: IssueTableViewCell.self)
        cell.selectionStyle = .none
        
        if let issue = viewModel.itemForIndexPath(indexPath) {
            cell.bind(issue)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemInSections(section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = DetailIssueViewController()
        self.navigationController?.pushViewController(view, animated: true)
    }
}

extension ListIssueViewController: ListIssueViewModelDelegate {
    func performAction(_ action: ListIssueViewModel.Action) {
        hideLoading()
        
        switch action {
        case .didFetch, .didLoadMore:
            self.tableView.reloadData()
        default:
            debugPrint("abc")
        }
    }
}
