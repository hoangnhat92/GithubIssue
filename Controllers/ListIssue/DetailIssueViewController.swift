//
//  DetailIssueViewController.swift
//  GithubIssue
//
//  Created by nhat on 10/18/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import UIKit
import SnapKit

final class DetailIssueViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize(width: self.view.frame.width, height: 100)
        
        let clView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        clView.keyboardDismissMode = .interactive
        clView.delegate = self
        clView.dataSource = self        
        
        return clView
    }()
    
    private lazy var footerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var commentTextfield: UITextField = {
        let txt = UITextField()
        txt.textColor = .white
        txt.layer.borderWidth = 1.0
        txt.layer.borderColor = UIColor.white.cgColor
        return txt
    }()
    
    private lazy var sendButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Send", for: .normal)
        return btn
    }()
    
    var bottomConstraint: Constraint? = nil
    
    let viewModel: DetailIssueViewModel
    
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
        registerCells()
        registerNotifications()
    }
    
    // MARK: - Set up
    
    fileprivate func setupView() {
        view.addSubview(collectionView)
        
        footerView.addSubview(commentTextfield)
        footerView.addSubview(sendButton)
        view.addSubview(footerView)
        
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
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
    
    // MARK: - IBActions
    
    
    
}

// MARK: - Extensions

extension DetailIssueViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
            
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath,
                                                      cellType: CommentCollectionViewCell.self)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                     for: indexPath,
                                                                     viewType: HeaderDetailIssueView.self)
        header.bindViewModel(viewModel.getHeaderDetailIssue())
        return header
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        let indexPath = IndexPath(row: 0, section: section)
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                     for: indexPath,
                                                                     viewType: HeaderDetailIssueView.self)
        
        header.setPreferredLayoutWith(collectionView.frame.width)
        header.setNeedsLayout()
        header.layoutIfNeeded()
        
        let frame = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return CGSize(width: collectionView.frame.size.width, height: frame.height)
    }
}
