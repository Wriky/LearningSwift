//
//  ChatListTableCell.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/8/8.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit


class ChatListTableCell: BaseTableViewCell {

    private lazy var avatarImgView: UIImageView = {
        let avatarImgView = UIImageView()
        avatarImgView.clipsToBounds = true
        avatarImgView.layer.cornerRadius = 20
        return avatarImgView
    }()
    
    private lazy var nameLbl: UILabel = {
        let nameLbl = UILabel()
        nameLbl.font = UIFont.systemFont(ofSize: 15)
        nameLbl.textColor = UIColor.black
        return nameLbl
    }()
    
    private lazy var messageLbl: UILabel = {
        let messageLbl = UILabel()
        messageLbl.font = UIFont.systemFont(ofSize: 13)
        messageLbl.textColor = UIColor.lightGray
        return messageLbl
    }()
    
    func configureWithItem(_ item: TableViewItem){
        avatarImgView.image = UIImage.init(named: "icon_center_information_upload")
        nameLbl.text = item.title
        messageLbl.text = item.subTitle
    }
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        contentView.addSubview(avatarImgView)
        contentView.addSubview(nameLbl)
        contentView.addSubview(messageLbl)
        
        self.makeConstraints()
        
    }
    
    func makeConstraints() {
        avatarImgView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 40, height: 40))
            $0.left.equalTo(20)
            $0.top.equalTo(15)
        }
        
        nameLbl.snp.makeConstraints {
            $0.left.equalTo(avatarImgView.snp.right).offset(10)
            $0.top.equalTo(avatarImgView.snp.top)
        }
        messageLbl.snp.makeConstraints {
            $0.left.equalTo(nameLbl.snp.left)
            $0.top.equalTo(nameLbl.snp.bottom).offset(5)
            $0.bottom.equalTo(-15)
        }
        
    }
}
