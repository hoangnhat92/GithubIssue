//
//  AuthenticationViewController.swift
//  GithubIssue
//
//  Created by nhat on 10/17/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import UIKit
import SnapKit
import Toaster

protocol AuthenticationDelegate: class {
    func didFinishAuthentication(_ repository: Repository)
}

final class AuthenticationViewController: UIViewController {

    // MARK: - Properties
    
    let viewModel: AuthenticationViewModel
    
    weak var delegate: AuthenticationDelegate?
    
    private lazy var logoImageView: UIImageView = {
        let img = UIImage(named: "ico_github")
        let imgView = UIImageView(image: img)
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    private lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 1
        lb.text = "GitHub"
        lb.textAlignment = .center
        lb.textColor = .white
        lb.font = UIFont.boldSystemFont(ofSize: 23)
        return lb
    }()
    
    private lazy var repositoryNameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Repository Name"
        lb.textColor = .white
        return lb
    }()
    
    private lazy var ownerNameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Owner Name"
        lb.textColor = .white
        return lb
    }()
    
    private lazy var tokenLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Private Token"
        lb.textColor = .white
        return lb
    }()
    
    private lazy var repositoryNameTextfield: UITextField = {
        let txt = makeTextfield()
        return txt
    }()
    
    private lazy var ownerNameTextfield: UITextField = {
        let txt = makeTextfield()
        return txt
    }()
    
    private lazy var tokenTextfield: UITextField = {
        let txt = makeTextfield()
        return txt
    }()
    
    private lazy var submitButton: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(onClickSubmitButton), for: .touchUpInside)
        btn.setTitle("Submit", for: .normal)
        return btn
    }()
    
    
    // MARK: - Initialize
    init(viewModel: AuthenticationViewModel = AuthenticationViewModel()) {
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
        
        #if DEBUG
        setupMockData()
        #endif
    }
    
    // MARK: - Set up
    
    fileprivate func setupView() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
        
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(repositoryNameLabel)
        view.addSubview(ownerNameLabel)
        view.addSubview(tokenLabel)
        view.addSubview(repositoryNameTextfield)
        view.addSubview(ownerNameTextfield)
        view.addSubview(tokenTextfield)
        view.addSubview(submitButton)
    }
    
    fileprivate func setupLayout() {
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(50)
            make.centerX.equalTo(view).offset(-50)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(logoImageView)
            make.left.equalTo(logoImageView.snp.right).offset(10)
        }
        
        repositoryNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.left.right.equalTo(view).inset(16)
        }
        
        repositoryNameTextfield.snp.makeConstraints { (make) in
            make.top.equalTo(repositoryNameLabel.snp.bottom).offset(10)
            make.height.equalTo(30)
            make.left.right.equalTo(view).inset(16)
        }
        
        ownerNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(repositoryNameTextfield.snp.bottom).offset(16)
            make.left.right.equalTo(view).inset(16)
        }
        
        ownerNameTextfield.snp.makeConstraints { (make) in
            make.top.equalTo(ownerNameLabel.snp.bottom).offset(10)
            make.height.equalTo(30)
            make.left.right.equalTo(view).inset(16)
        }
        
        tokenLabel.snp.makeConstraints { (make) in
            make.top.equalTo(ownerNameTextfield.snp.bottom).offset(16)
            make.left.right.equalTo(view).inset(16)
        }
        
        tokenTextfield.snp.makeConstraints { (make) in
            make.top.equalTo(tokenLabel.snp.bottom).offset(10)
            make.height.equalTo(30)
            make.left.right.equalTo(view).inset(16)
        }
        
        submitButton.snp.makeConstraints { (make) in
            make.top.equalTo(tokenTextfield.snp.bottom).offset(32)
            make.centerX.equalTo(view)
        }
    }
    
    fileprivate func setupMockData() {
        repositoryNameTextfield.text = "GithubIssue"
        ownerNameTextfield.text = "hoangnhat92"
        
        let subString = "999cd8"
        tokenTextfield.text = "79417a3eebd31c8d18a6be1de3859f94f7\(subString)"
    }
    
    fileprivate func setupViewModel() {
        viewModel.delegate = self
    }
    
    // MARK: - IBActions
    
    @objc fileprivate func onClickSubmitButton() {
        guard let owner = ownerNameTextfield.text, !owner.isEmpty else {
            return
        }
        
        guard let repository = repositoryNameTextfield.text, !repository.isEmpty else {
            return
        }
        
        guard let token = tokenTextfield.text, !token.isEmpty else {
            return
        }
        
        view.endEditing(true)        
        showLoading()
        viewModel.loginWith(owner: owner, repositiory: repository, token: token)
    }
}

// MARK: - Extensions

extension AuthenticationViewController {
    fileprivate func makeTextfield() -> UITextField {
        let txt = UITextField()
        txt.setPadding()
        txt.textColor = .white
        txt.layer.cornerRadius = 5
        txt.layer.masksToBounds = true
        txt.layer.borderColor = UIColor.white.cgColor
        txt.layer.borderWidth = 1.0
        return txt
    }
}

extension AuthenticationViewController: AuthenticationViewModelDelegate {
    func didLoginSuccessfully(with repository: Repository) {
        hideLoading()
        delegate?.didFinishAuthentication(repository)
    }
    
    func didLoginFailed(_ error: Error) {
        hideLoading()
        Toast(text: error.localizedDescription).show()
    }
}
