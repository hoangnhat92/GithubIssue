//
//  CommentCollectionViewCell.swift
//  GithubIssue
//
//  Created by nhat on 10/19/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import UIKit
import Reusable
import SDWebImage

protocol CommentCollectionViewCellDelegate: class {
    func performActionButtton(_ comment: CommentDetail)
}

final class CommentCollectionViewCell: UICollectionViewCell, Reusable {
    
    // MARK: - Properties
    
    weak var delegate: CommentCollectionViewCellDelegate?
    
    var viewModel: CommentDetail! {
        didSet {
            guard let author = viewModel.author else { return }
            
            if let url = URL(string: author.avatarUrl) {
                avatarImageView.sd_setImage(with: url)
            }
            
            
            ownerNameLabel.text = author.login
            commentLabel.text = viewModel.bodyText
            createdAtLabel.text = viewModel.createdAt.timeAgo()
            // Only show action button when the viewer is author of this comment
            actionButton.isHidden = !viewModel.viewerDidAuthor
        }
    }
    
    private lazy var avatarImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.layer.borderColor = UIColor.lightGray.cgColor
        imgView.layer.borderWidth = 1.0
        imgView.contentMode = .scaleAspectFit
        imgView.layer.cornerRadius = 20
        imgView.layer.masksToBounds = true
        return imgView
    }()
    
    private lazy var ownerNameLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.font = Font.medium.normal
        return lb
    }()
    
    private lazy var commentLabel: UILabel = {
        let lb = UILabel()
        lb.font = Font.regular.normal
        lb.textColor = .white
        lb.numberOfLines = 0
        lb.lineBreakMode = .byWordWrapping
        return lb
    }()
    
    private lazy var createdAtLabel: UILabel = {
        let lb = UILabel()
        lb.font = Font.regular.normal
        lb.textColor = .lightGray
        lb.numberOfLines = 1
        return lb
    }()
    
    private lazy var actionButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        btn.setImage(UIImage(named: "ic_menu"), for: .normal)
        btn.addTarget(self,
                      action: #selector(onClickActionButton),
                      for: .touchUpInside)
        return btn
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
        commentLabel.preferredMaxLayoutWidth = layoutAttributes.size.width - Constants.margin * 2
        ownerNameLabel.preferredMaxLayoutWidth = layoutAttributes.size.width - Constants.margin * 2
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }
    
    // MARK: - Set up
    
    fileprivate func setupView() {
        backgroundColor = UIColor.darkGray
        addSubview(avatarImageView)
        addSubview(ownerNameLabel)
        addSubview(commentLabel)
        addSubview(actionButton)
        addSubview(createdAtLabel)
    }
    
    fileprivate func setupLayout() {
        avatarImageView.snp.makeConstraints { (make) in
            make.size.equalTo(40)
            make.top.left.equalToSuperview().inset(Constants.margin)
        }
        
        ownerNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImageView)
            make.left.equalTo(avatarImageView.snp.right).offset(10)
        }
        
        createdAtLabel.snp.makeConstraints { (make) in
            make.left.equalTo(ownerNameLabel.snp.right).offset(10)
            make.centerY.equalTo(ownerNameLabel)
            make.right.greaterThanOrEqualTo(actionButton.snp.left).offset(-16)
        }
        
        ownerNameLabel.setContentHuggingPriority(.init(250), for: .horizontal)
        createdAtLabel.setContentHuggingPriority(.init(251), for: .horizontal)
        
        commentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(ownerNameLabel.snp.bottom).offset(5)
            make.left.equalTo(ownerNameLabel)
            make.right.equalToSuperview().offset(-Constants.margin)
            make.bottom.lessThanOrEqualTo(self).priority(1000)
        }
        
        actionButton.snp.makeConstraints { (make) in
            make.size.equalTo(30)
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(ownerNameLabel)
        }
    }
    
    // MARK: - IBActions
    @objc fileprivate func onClickActionButton() {
        delegate?.performActionButtton(viewModel)
    }
}

private extension Constants {
    static let margin: CGFloat = 16
}

