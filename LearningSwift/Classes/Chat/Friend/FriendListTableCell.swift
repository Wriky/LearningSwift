//
//  FriendListTableCell.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/9/5.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit

class FriendListTableCell: BaseTableViewCell {

    private lazy var avatarView: UIImageView = {
        let avatarView = UIImageView()
        avatarView.layer.cornerRadius = 20
        avatarView.clipsToBounds = true
        return avatarView
    }()
    
    private lazy var nameLbl: UILabel = {
        let nameLbl = UILabel()
        nameLbl.font = UIFont.systemFont(ofSize: 14)
        nameLbl.textColor = UIColor.black
        return nameLbl
    }()
    
    private lazy var messageLbl: UILabel = {
        let messageLbl = UILabel()
        messageLbl.font = UIFont.systemFont(ofSize: 13)
        messageLbl.textColor = UIColor.lightGray
        return messageLbl
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = UIColor.white
        self.selectionStyle = UITableViewCellSelectionStyle.none
        self.configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        contentView.addSubview(avatarView)
        contentView.addSubview(nameLbl)
        contentView.addSubview(messageLbl)

        self.makeConstraints()
    }
    
    func makeConstraints() {
        avatarView.snp.makeConstraints {
            $0.top.equalTo(15)
            $0.left.equalTo(20)
            $0.size.equalTo(CGSize(width: 40, height: 40))
            $0.bottom.equalTo(-15)
        }
        nameLbl.snp.makeConstraints {
            $0.top.equalTo(avatarView.snp.top).offset(3)
            $0.left.equalTo(avatarView.snp.right).offset(10)
        }
        messageLbl.snp.makeConstraints {
            $0.top.equalTo(nameLbl.snp.bottom).offset(3)
            $0.left.equalTo(nameLbl.snp.left)
        }
    }
    
    func configureWithItem(_ item: UserModel) {
        avatarView.backgroundColor = UIColor.lightGray
        nameLbl.text = item.nick_name
        messageLbl.text = "My phone number \(item.mobile)"
    }

}
