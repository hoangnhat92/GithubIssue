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
    private let viewModel: AuthenticationViewModel
    
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
        lb.font = Font.bold.largeTitle
        return lb
    }()
    
    private lazy var repositoryNameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Repository Name"
        lb.textColor = .white
        lb.font = Font.bold.subttile
        return lb
    }()
    
    private lazy var ownerNameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Owner Name"
        lb.textColor = .white
        lb.font = Font.bold.subttile
        return lb
    }()
    
    private lazy var tokenLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Private Token"
        lb.textColor = .white
        lb.font = Font.bold.subttile
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
        btn.addBorder(radius: 10)
        btn.addTarget(self, action: #selector(onClickSubmitButton), for: .touchUpInside)
        btn.setTitle("Sign-in", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = Font.bold.normal
        btn.backgroundColor = UIColor.blueGray
        return btn
    }()
    
    var didLayoutSubViews: Bool = false
    
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        defer {
            didLayoutSubViews = true
        }
        
        if !didLayoutSubViews {
            repositoryNameTextfield.addUnderline()
            ownerNameTextfield.addUnderline()
            tokenTextfield.addUnderline()
        }
    }
    
    // MARK: - Set up
    
    fileprivate func setupView() {
        view.backgroundColor = UIColor.darkGray                
        
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(repositoryNameLabel)
        view.addSubview(ownerNameLabel)
        view.addSubview(tokenLabel)
        view.addSubview(repositoryNameTextfield)
        view.addSubview(ownerNameTextfield)
        view.addSubview(tokenTextfield)
        view.addSubview(submitButton)
        
        addGesture()
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
            make.left.right.equalTo(view).inset(Constants.margin)
        }
        
        repositoryNameTextfield.snp.makeConstraints { (make) in
            make.top.equalTo(repositoryNameLabel.snp.bottom).offset(10)
            make.height.equalTo(30)
            make.left.right.equalTo(view).inset(Constants.margin)
        }
        
        ownerNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(repositoryNameTextfield.snp.bottom).offset(16)
            make.left.right.equalTo(view).inset(Constants.margin)
        }
        
        ownerNameTextfield.snp.makeConstraints { (make) in
            make.top.equalTo(ownerNameLabel.snp.bottom).offset(10)
            make.height.equalTo(30)
            make.left.right.equalTo(view).inset(Constants.margin)
        }
        
        tokenLabel.snp.makeConstraints { (make) in
            make.top.equalTo(ownerNameTextfield.snp.bottom).offset(16)
            make.left.right.equalTo(view).inset(Constants.margin)
        }
        
        tokenTextfield.snp.makeConstraints { (make) in
            make.top.equalTo(tokenLabel.snp.bottom).offset(10)
            make.height.equalTo(30)
            make.left.right.equalTo(view).inset(Constants.margin)
        }
        
        submitButton.snp.makeConstraints { (make) in
            make.width.equalTo(120)
            make.height.equalTo(40)
            make.top.equalTo(tokenTextfield.snp.bottom).offset(32)
            make.centerX.equalTo(view)
        }
    }
    
    fileprivate func setupMockData() {
        repositoryNameTextfield.text = "GithubIssue"
        ownerNameTextfield.text = "hoangnhat92"
        
        let lastFiveCharacter = "ceeaa"
        tokenTextfield.text = "10333fdf383c2fea3c5a15722d58fe635e9\(lastFiveCharacter)"
    }
    
    fileprivate func setupViewModel() {
        viewModel.delegate = self
    }
    
    fileprivate func addGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onClickToScreen))
        gesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(gesture)
    }
    
    @objc fileprivate func onClickToScreen() {
        view.endEditing(true)
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
        txt.delegate = self
        txt.textColor = .white
        txt.clearButtonMode = .whileEditing
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

extension AuthenticationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

// MARK: - Configurations

private extension Constants {
    static let margin: CGFloat = 32
}
