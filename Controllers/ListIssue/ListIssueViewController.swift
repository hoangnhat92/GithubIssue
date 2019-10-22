//
//  ListIssueViewController.swift
//  GithubIssue
//
//  Created by nhat on 10/17/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import UIKit
import Reusable
import Toaster


protocol ListIssueViewControllerDelegate: class {
    func goToDetailIssue(_ issue: IssueDetail) 
}

final class ListIssueViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: ListIssueViewControllerDelegate?
    
    private let viewModel: ListIssueViewModel
    
    private var issues: [IssueDetail]?
    
    private lazy var tableView: UITableView =  {
        let tblView = UITableView()
        tblView.backgroundColor = .black
        tblView.separatorColor = .darkGray
        
        tblView.delegate = self
        tblView.dataSource = self
        return tblView
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(onPullToRefresh), for: .valueChanged)
        return refresh
    }()
    
    // MARK: - Initializers
    
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
        setupHeaderTableView()
        setupRefreshControl()
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
    
    fileprivate func setupRefreshControl() {
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
    }
    
    // MARK: - IBActions
    @objc fileprivate func onPullToRefresh() {
        refreshControl.beginRefreshing()
        viewModel.getListIssue()
    }
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
        guard let issue = viewModel.itemForIndexPath(indexPath) else { return }
        
        delegate?.goToDetailIssue(issue)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.shouldLoadMoreData(indexPath) {            
            viewModel.loadMoreListIssue()
        }
    }
}

extension ListIssueViewController: ListIssueViewModelDelegate {
    func performAction(_ action: ListIssueViewModel.Action) {
        hideLoading()
        
        switch action {
        case .didFetch :
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.refreshControl.endRefreshing()
            }
            tableView.reloadData()
        case .didLoadMore:
            tableView.reloadData()
        case .didFail(let error):
            Toast(text: error.localizedDescription).show()
        }
    }
}
