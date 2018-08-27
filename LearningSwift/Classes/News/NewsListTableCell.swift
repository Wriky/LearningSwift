//
//  NewsListTableCell.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/8/27.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit

class NewsListTableCell: BaseTableViewCell {

    private lazy var iconImgView: UIImageView = {
        let iconImgView = UIImageView()
        return iconImgView
    }()
    
    private lazy var titleLbl: UILabel = {
        let titleLbl = UILabel()
        titleLbl.font = UIFont.systemFont(ofSize: 15)
        titleLbl.textColor = UIColor.black
        return titleLbl
    }()
    
    private lazy var subTitleLbl: UILabel = {
        let subTitleLbl = UILabel()
        subTitleLbl.font = UIFont.systemFont(ofSize: 13)
        subTitleLbl.textColor = UIColor.lightGray
        return subTitleLbl
    }()
    
    func configureWithItem(_ item: NewsListTableItem){
        iconImgView.image = UIImage.init(named: item.iconStr)
        titleLbl.text = item.titleStr
        subTitleLbl.text = item.subTitleStr
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        contentView.addSubview(iconImgView)
        contentView.addSubview(titleLbl)
        contentView.addSubview(subTitleLbl)
        
        self.makeConstraints()
        
    }
    
    func makeConstraints() {
        iconImgView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 40, height: 40))
            $0.left.equalTo(20)
            $0.top.equalTo(15)
        }
        
        titleLbl.snp.makeConstraints {
            $0.left.equalTo(iconImgView.snp.right).offset(10)
            $0.top.equalTo(iconImgView.snp.top)
        }
        subTitleLbl.snp.makeConstraints {
            $0.left.equalTo(titleLbl.snp.left)
            $0.top.equalTo(titleLbl.snp.bottom).offset(5)
            $0.bottom.equalTo(-15)
        }
        
    }

}
