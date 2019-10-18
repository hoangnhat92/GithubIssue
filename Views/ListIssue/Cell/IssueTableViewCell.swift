//
//  IssueTableViewCell.swift
//  GithubIssue
//
//  Created by nhat on 10/18/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import UIKit
import Reusable

final class IssueTableViewCell: UITableViewCell, Reusable {

    // MARK: - Properties
    
    private lazy var idLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.text = "1"
        lb.textAlignment = .center
        return lb
    }()
    
    private lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.text = "Title"
        return lb
    }()
    
    private lazy var createdAtLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.text = "Created at"
        return lb
    }()
    
    private lazy var statusLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.text = "Open"
        return lb
    }()
    
    private lazy var ownerNameLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.text = "Nhat"
        return lb
    }()
    
    private lazy var leftView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var rightView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var mainStackView: UIStackView  = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        return stackview
    }()
    
    // MARK: - Initialize
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    fileprivate func setupView() {
        
        backgroundColor = .black
        
        leftView.addSubview(idLabel)
        addSubview(leftView)
        
        mainStackView.addArrangedSubview(titleLabel)
        let descStackView = UIStackView()
        descStackView.distribution = .fillProportionally
        descStackView.axis = .horizontal
        
        descStackView.addArrangedSubview(statusLabel)
        descStackView.addArrangedSubview(ownerNameLabel)
        descStackView.addArrangedSubview(createdAtLabel)
        
        mainStackView.addArrangedSubview(descStackView)
        
        rightView.addSubview(mainStackView)
        addSubview(rightView)
    }
    
    fileprivate func setupLayout() {
        
        leftView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self).inset(5)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        idLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(leftView).offset(5)
        }
        
        rightView.snp.makeConstraints { (make) in            
            make.left.equalTo(leftView.snp.right)
            make.right.top.bottom.equalTo(self).inset(5)
        }
        
        mainStackView.snp.makeConstraints { (make) in
            make.edges.equalTo(rightView)
        }
    }
}
