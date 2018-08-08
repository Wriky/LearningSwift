//
//  ChatTableCell.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/8/8.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit


class ChatTableCell: BaseTableViewCell {

    private lazy var avatarImgView: UIImageView = {
        let avatarImgView = UIImageView()
        avatarImgView.clipsToBounds = true
        avatarImgView.layer.cornerRadius = 20
        avatarImgView.image = UIImage.init(named: "mine_tabbar_32x32_")
        return avatarImgView
    }()
    
    private lazy var messageLbl: UILabel = {
        let messageLbl = UILabel()
        messageLbl.font = UIFont.systemFont(ofSize: 14)
        messageLbl.textColor = UIColor.black
        return messageLbl
    }()
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        contentView.addSubview(avatarImgView)
        contentView.addSubview(messageLbl)
        
        self.makeConstraints()
        
    }
    
    func makeConstraints() {
        avatarImgView.snp.makeConstraints {
            $0.left.top.equalTo(contentView).offset(20)
            $0.size.equalTo(CGSize(width: 40, height: 40))
        }
    }
}
