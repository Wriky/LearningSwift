//
//  NewsDetailViewController.swift
//  LearningSwift
//
//  Created by wangyuan on 2019/1/7.
//  Copyright © 2019 wangyuan. All rights reserved.
//

import UIKit

class NewsDetailViewController: BaseViewController {
    var detailModel: NewsModel?
    
    private lazy var contentLbl: UILabel = {
        let contentLbl = UILabel()
        contentLbl.numberOfLines = 0
        return contentLbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.contentLbl)
        self.contentLbl.text = detailModel?.abstract
        
        self.contentLbl.snp.makeConstraints {
            $0.top.equalTo(100)
            $0.centerX.equalTo(self.view)
            $0.left.equalTo(15)
            $0.right.equalTo(-15)
        }
       
    }
    

    

}
