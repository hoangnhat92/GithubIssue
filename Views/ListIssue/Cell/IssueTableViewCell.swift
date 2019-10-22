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
        lb.textAlignment = .center
        lb.font = Font.bold.title
        return lb
    }()
    
    private lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 1
        lb.textColor = .white
        lb.font = Font.medium.subttile
        return lb
    }()
    
    private lazy var createdAtLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.font = Font.regular.small
        return lb
    }()
    
    private lazy var statusLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.font = Font.regular.small
        return lb
    }()
    
    private lazy var ownerNameLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.font = Font.regular.small
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
        
        backgroundColor = UIColor.darkGray
        
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
            make.left.top.equalTo(self)
            make.bottom.equalTo(self).offset(-10)
            make.width.equalTo(80)
        }
        
        idLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(leftView)
        }
        
        rightView.snp.makeConstraints { (make) in            
            make.left.equalTo(leftView.snp.right)
            make.right.top.equalTo(self)
            make.bottom.equalTo(self).offset(-10)
        }
        
        mainStackView.snp.makeConstraints { (make) in
            make.edges.equalTo(rightView)
        }
    }
    
    func bind(_ model: IssueDetail) {
        idLabel.text = "#\(model.number)"
        titleLabel.text = model.title
        ownerNameLabel.text = model.author?.login
        createdAtLabel.text = model.createdAt.timeAgo()
        statusLabel.text = model.state.rawValue
        statusLabel.textColor = model.statusColor
    }
}

fileprivate extension IssueDetail {
    var statusColor: UIColor {
        switch self.state {
        case .open:
            return .green
        case .closed:
           return .red
        case .__unknown(_):
            return .white
        }
    }
}
