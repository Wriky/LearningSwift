//
//  ChatDetailTableCell.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/8/8.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit

class ChatDetailTableCell: BaseTableViewCell {
    private lazy var avatarView: UIImageView = {
        let avatarView = UIImageView()
        avatarView.layer.cornerRadius = 20
        avatarView.clipsToBounds = true
        return avatarView
    }()
    
    private lazy var bubbleView: UIImageView = {
        let bubbleView = UIImageView()
        let bubbleImage = UIImage.init(named: "chat_bg_right")!
        let resizable = bubbleImage.resizableImage(withCapInsets: UIEdgeInsetsMake(10, 10, 10, 10), resizingMode: UIImageResizingMode.stretch)
        bubbleView.image = resizable
        return bubbleView
    }()
    
    private lazy var contentLbl: UILabel = {
        let contentLbl = UILabel()
        contentLbl.font = UIFont.systemFont(ofSize: 12)
        contentLbl.numberOfLines = 0
        contentLbl.preferredMaxLayoutWidth = 200
        return contentLbl
    }()
    
    private lazy var activityView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView.init(activityIndicatorStyle:UIActivityIndicatorViewStyle.gray)
        return activityView
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        contentView.addSubview(avatarView)
        contentView.addSubview(bubbleView)
        bubbleView.addSubview(contentLbl)
        contentView.addSubview(activityView)
        
        self.makeConstraints()
    }
    
    func makeConstraints() {
        avatarView.snp.makeConstraints {
            $0.top.equalTo(15)
            $0.right.equalTo(-20)
            $0.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        bubbleView.snp.makeConstraints {
            $0.top.equalTo(avatarView.snp.top)
            $0.right.equalTo(avatarView.snp.left).offset(-5)
            $0.width.lessThanOrEqualTo(230)
            $0.bottom.equalTo(-15)
        }
        
        contentLbl.snp.makeConstraints {
            $0.edges.equalTo(UIEdgeInsetsMake(10, 12, 10, 18))
        }
        
        activityView.snp.makeConstraints {
            $0.right.equalTo(bubbleView.snp.left).offset(-3)
            $0.centerY.equalTo(bubbleView.snp.centerY)
        }
    }
    
    func configureWithItem(_ item: MessageTableItem) {
        avatarView.image = UIImage.init(named: "icon_center_information_upload")
        contentLbl.text = item.contentStr
    }

}
