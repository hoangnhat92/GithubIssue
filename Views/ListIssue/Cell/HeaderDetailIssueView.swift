//
//  HeaderDetailIssueView.swift
//  GithubIssue
//
//  Created by nhat on 10/19/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import UIKit
import Reusable

class HeaderDetailIssueView: UICollectionReusableView, Reusable {
    
    // MARK: - Properties
    
    private lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.lineBreakMode = .byWordWrapping
        lb.textColor = .white
        lb.text = "title"
        return lb
    }()
    
    private lazy var bodyLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.lineBreakMode = .byWordWrapping
        lb.textColor = .white
        lb.text = "description"
        return lb
    }()
    
    private lazy var commentLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        lb.text = "Comments"
        return lb
    }()
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up
    
    fileprivate func setupView() {
        addSubview(titleLabel)
        addSubview(bodyLabel)
        addSubview(commentLabel)
    }
    
    fileprivate func setupLayout() {
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self).inset(16)
        }
                        
        bodyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.equalTo(self).inset(16)
        }
                
        commentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(bodyLabel.snp.bottom).offset(16)
            make.left.right.equalTo(self).inset(16)
            make.bottom.lessThanOrEqualTo(self).priority(1000)
        }
        
        commentLabel.setContentHuggingPriority(.init(251), for: .vertical)
        titleLabel.setContentHuggingPriority(.init(251), for: .vertical)
        bodyLabel.setContentHuggingPriority(.init(250), for: .vertical)
    }
    
    
    // MARK: - IBActions
    
    
    // MARK: - Functions
    func setPreferredLayoutWith(_ width: CGFloat) {
        titleLabel.preferredMaxLayoutWidth = width
        bodyLabel.preferredMaxLayoutWidth = width
    }
}
