//
//  CommentCollectionViewCell.swift
//  GithubIssue
//
//  Created by nhat on 10/19/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import UIKit
import Reusable

final class CommentCollectionViewCell: UICollectionViewCell, Reusable {
    
    // MARK: - Properties
    lazy var avatarImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .red
        return imgView
    }()
    
    lazy var ownerNameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "title"
        lb.textColor = .white
        return lb
    }()
    
    lazy var commentLabel: UILabel = {
        let lb = UILabel()
        lb.text = "text"
        lb.textColor = .white
        lb.numberOfLines = 0
        lb.lineBreakMode = .byWordWrapping
        return lb
    }()
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        commentLabel.preferredMaxLayoutWidth = layoutAttributes.size.width
        ownerNameLabel.preferredMaxLayoutWidth = layoutAttributes.size.width
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }
    
    // MARK: - Set up
    
    fileprivate func setupView() {
        addSubview(avatarImageView)
        addSubview(ownerNameLabel)
        addSubview(commentLabel)
    }
    
    fileprivate func setupLayout() {
        avatarImageView.snp.makeConstraints { (make) in
            make.size.equalTo(30)
            make.top.left.equalToSuperview().inset(16)
        }
        
        ownerNameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(avatarImageView)
            make.left.equalTo(avatarImageView.snp.right).offset(5)
            make.right.equalToSuperview().offset(-5)
        }
        
        commentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImageView.snp.bottom).offset(5)
            make.left.equalTo(ownerNameLabel)
            make.right.equalToSuperview().offset(-16)
            make.bottom.lessThanOrEqualTo(self).priority(1000)
        }
    }
}

