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
    
    private lazy var nameLbl: UILabel = {
        let nameLbl = UILabel()
        nameLbl.font = UIFont.systemFont(ofSize: 12)
        nameLbl.textColor = UIColor.lightGray
        return nameLbl
    }()
    
    private lazy var bubbleView: UIImageView = {
        let bubbleView = UIImageView()
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
        let activityView = UIActivityIndicatorView.init(style:UIActivityIndicatorView.Style.gray)
        return activityView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        self.contentView.backgroundColor = RGB(237, 237, 246)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        contentView.addSubview(avatarView)
        contentView.addSubview(nameLbl)
        contentView.addSubview(bubbleView)
        bubbleView.addSubview(contentLbl)
        contentView.addSubview(activityView)
        
        self.makeConstraints()
    }
    
    func makeConstraints() {
        avatarView.snp.makeConstraints {
            $0.top.equalTo(15)
            $0.left.equalTo(20)
            $0.size.equalTo(CGSize(width: 40, height: 40))
        }
        nameLbl.snp.makeConstraints {
            $0.top.equalTo(avatarView.snp.top).offset(-3)
            $0.left.equalTo(avatarView.snp.right).offset(10)
        }
        bubbleView.snp.makeConstraints {
            $0.top.equalTo(nameLbl.snp.bottom).offset(2)
            $0.width.lessThanOrEqualTo(230)
            $0.bottom.equalTo(-15)
            $0.left.equalTo(avatarView.snp.right).offset(5)
        }
        
        contentLbl.snp.makeConstraints {
            $0.edges.equalTo(UIEdgeInsets(top: 10, left: 18, bottom: 10, right: 12))
        }
        
        activityView.snp.makeConstraints {
            $0.left.equalTo(bubbleView.snp.right).offset(3)
            $0.centerY.equalTo(bubbleView.snp.centerY)
        }
    }
    
    func updateConstraints(_ isLeft: Bool) {
        avatarView.snp.remakeConstraints {
            $0.top.equalTo(15)
            if isLeft {
                $0.left.equalTo(20)
            } else {
                $0.right.equalTo(-20)
            }
            $0.size.equalTo(CGSize(width: 40, height: 40))
        }
        nameLbl.snp.remakeConstraints {
            $0.top.equalTo(avatarView.snp.top).offset(-3)
            if isLeft {
                $0.left.equalTo(avatarView.snp.right).offset(10)
            } else {
                $0.right.equalTo(avatarView.snp.left).offset(-10)
            }
        }
        bubbleView.snp.remakeConstraints {
            $0.top.equalTo(nameLbl.snp.bottom).offset(2)
            $0.width.lessThanOrEqualTo(230)
            $0.bottom.equalTo(-15)
            if isLeft {
                $0.left.equalTo(avatarView.snp.right).offset(5)
            } else {
                $0.right.equalTo(avatarView.snp.left).offset(-5)
            }
        }
        
        contentLbl.snp.remakeConstraints {
            if isLeft {
                $0.edges.equalTo(UIEdgeInsets(top: 10, left: 18, bottom: 10, right: 12))
            } else {
                $0.edges.equalTo(UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 18))
            }
        }
        
        activityView.snp.remakeConstraints {
            if isLeft {
                $0.left.equalTo(bubbleView.snp.right).offset(3)
            } else {
                $0.right.equalTo(bubbleView.snp.left).offset(-3)
            }
            $0.centerY.equalTo(bubbleView.snp.centerY)
        }
    }
    
    func configureWithItem(_ item: MessageModel,_ user: UserModel) {
        let isLeft: Bool = (item.user_id != "10")
        
        self.updateConstraints(isLeft)
        
        let bubbleImage = UIImage.init(named: (isLeft ? "chat_bg_left":"chat_bg_right"))!
        let resizable = bubbleImage.resizableImage(withCapInsets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), resizingMode: UIImage.ResizingMode.stretch)
        bubbleView.image = resizable

        avatarView.image = UIImage.init(named: "icon_center_information_upload")
        
        let name: String = isLeft ? user.nick_name : "DownLoad"
        nameLbl.text =  name
        
        contentLbl.attributedText = FaceManager.transferMessageToEmoji(message: item.content, font: contentLbl.font, lineHeight: contentLbl.font.lineHeight)
    }

}
