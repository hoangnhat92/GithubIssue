//
//  DetailIssueViewController.swift
//  GithubIssue
//
//  Created by nhat on 10/18/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import UIKit
import SnapKit
import Toaster

protocol DetailIssueViewControllerDelegate: class {
    func didCloseIssue()
}

final class DetailIssueViewController: UIViewController {
    
    // MARK: - Properties
    weak var delegate: DetailIssueViewControllerDelegate?
    
    enum State {
        case normal
        case editing(String)
    }
    
    private var isDidLayoutSubView: Bool = false
    
    private var state: State = .normal
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize(width: self.view.frame.width, height: 100)
        
        let clView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        clView.keyboardDismissMode = .interactive
        clView.delegate = self
        clView.dataSource = self
        clView.backgroundColor = UIColor.darkGray
        clView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        
        if #available(iOS 10.0, *) {
            clView.refreshControl = refreshControl
        } else {
            // Fallback on earlier versions
            clView.addSubview(refreshControl)
        }
        
        return clView
    }()
    
    private lazy var footerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var commentTextfield: UITextField = {
        let txt = UITextField()
        txt.textColor = .white
        txt.attributedPlaceholder = NSAttributedString(string: "Input your comment",
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        return txt
    }()
    
    private lazy var sendButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Send", for: .normal)
        btn.addTarget(self, action: #selector(onClickSendButton), for: .touchUpInside)        
        btn.titleLabel?.font = Font.bold.normal
        return btn
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(onPullToRefresh), for: .valueChanged)
        return refresh
    }()
    
    private var bottomConstraint: Constraint? = nil
    
    private let viewModel: DetailIssueViewModel
    
    // MARK: - Initializers
    
    init(viewModel: DetailIssueViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupLayout()
        setupViewModel()
        registerCells()
        registerNotifications()
        setupLoadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
     
        commentTextfield.addUnderline()
    }
    
    // MARK: - Set up
    
    fileprivate func setupView() {
        view.backgroundColor = UIColor.darkGray
        view.addSubview(collectionView)
        
        footerView.addSubview(commentTextfield)
        footerView.addSubview(sendButton)
        view.addSubview(footerView)
        
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
        
        if viewModel.shouldShowCloseIssueButton() {
            addRightBarButton()
        }
    }
    
    fileprivate func registerNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShowNotification(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHideNotification),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc fileprivate func keyboardWillShowNotification(notification: Notification) {
        guard
            let info = notification.userInfo,
            let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            else { return }
        
        UIView.animate(withDuration: 0.1) {
            self.bottomConstraint?.update(offset: -keyboardFrame.size.height)
        }
    }
    
    @objc fileprivate func keyboardWillHideNotification() {
        UIView.animate(withDuration: 0.1) {
            self.bottomConstraint?.update(offset: 0)
        }
    }
     
    fileprivate func setupLayout() {
        
        footerView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            if #available(iOS 11.0, *) {
                self.bottomConstraint = make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-16).constraint
            } else {
                self.bottomConstraint = make.bottom.equalTo(self.view.snp.bottom).offset(-16).constraint
            }
            make.height.equalTo(50)
            make.top.equalTo(collectionView.snp.bottom)
        }
        
        sendButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(footerView)
            make.right.equalTo(footerView).inset(10)
            make.width.equalTo(50)
        }
        
        commentTextfield.snp.makeConstraints { (make) in
            make.top.left.bottom.equalTo(footerView).inset(5)
            make.right.equalTo(sendButton.snp.left).offset(-5)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
    }
    
    fileprivate func registerCells() {
        collectionView.register(supplementaryViewType: HeaderDetailIssueView.self,
                                ofKind: UICollectionView.elementKindSectionHeader)
        collectionView.register(cellType: CommentCollectionViewCell.self)
    }
    
    fileprivate func setupViewModel() {
        viewModel.delegate = self
    }
    
    fileprivate func setupLoadData() {
        showLoading()
        viewModel.getListComment()
    }
    
    fileprivate func addRightBarButton() {
        let barButton = UIBarButtonItem(title: "Close",
                                        style: .plain,
                                        target: self,
                                        action: #selector(onClickToCloseButton))
        barButton.tintColor = .red
        barButton.setTitleTextAttributes([NSAttributedString.Key.font: Font.bold.normal], for: .normal)
        navigationItem.rightBarButtonItem = barButton
        
    }
    
    // MARK: - IBActions
    
    @objc fileprivate func onPullToRefresh() {
        refreshControl.beginRefreshing()
        viewModel.getListComment()
    }
    
    @objc fileprivate func onClickSendButton() {
        guard let text = commentTextfield.text, !text.isEmpty else { return }
        
        showLoading()
        view.endEditing(true)
        
        switch state {
        case .normal:
            viewModel.addCommentToIssue(text)
        case .editing(let id):
            viewModel.editComment(id, text: text)
        }
        
        commentTextfield.text = ""
    }
    
    fileprivate func enableEditMode(_ commentDetail: CommentDetail) {
        state = .editing(commentDetail.id)
        commentTextfield.text = commentDetail.bodyText
        commentTextfield.becomeFirstResponder()
    }
    
    @objc fileprivate func onClickToCloseButton() {
        let alert = UIAlertController(title: "Message", message: "Do you want to close this issue ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { (_) in
            self.showLoading()
            self.viewModel.closeIssue()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            
        }))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Extensions

extension DetailIssueViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemInSections(section)
    }
            
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel.itemForIndexPath(indexPath) else  { return UICollectionViewCell() }
        
        let cell = collectionView.dequeueReusableCell(for: indexPath,
                                                      cellType: CommentCollectionViewCell.self)
        cell.viewModel = viewModel
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let viewModel = viewModel.getHeaderDetailIssue() else {
            return UICollectionReusableView()
        }
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                     for: indexPath,
                                                                     viewType: HeaderDetailIssueView.self)
        header.bindViewModel(viewModel)
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if viewModel.shouldLoadMoreData(indexPath) {
            debugPrint("Reload at indexPath = \(indexPath.row)")
            viewModel.loadMoreListComment()
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        guard let viewModel = viewModel.getHeaderDetailIssue() else {
            return .zero
        }
        
        let indexPath = IndexPath(row: 0, section: section)
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                     for: indexPath,
                                                                     viewType: HeaderDetailIssueView.self)
        header.bindViewModel(viewModel)
        header.setPreferredLayoutWith(collectionView.frame.width)
        header.setNeedsLayout()
        header.layoutIfNeeded()
        
        let frame = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return CGSize(width: collectionView.frame.size.width, height: frame.height)
    }
}

extension DetailIssueViewController: DetailIssueViewModelDelegate {
    func performAction(_ action: DetailIssueViewModel.Action) {
        hideLoading()
        
        switch action {
        case .didEditComment:
            state = .normal
            viewModel.watchListComment()
        case .didDeleteComment, .didAddComment:
            collectionView.reloadData()
        case .didCloseIssue:
            delegate?.didCloseIssue()
        case .didFetch:
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
                self.refreshControl.endRefreshing()
            }
            collectionView.reloadData()
        case .didLoadMore:
            collectionView.reloadData()
        case .didFail(let error):
            Toast(text: error.localizedDescription).show()
        }
    }
}


extension DetailIssueViewController: CommentCollectionViewCellDelegate {
    func performActionButtton(_ comment: CommentDetail) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            self.enableEditMode(comment)
        }))
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            self.viewModel.deleteComment(comment.id)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}
