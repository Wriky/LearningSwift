//
//  SVProgressHUD+Extension.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/6/24.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import SVProgressHUD

extension SVProgressHUD {
    /// 设置 SVProgressHUD 属性
    static func configuration() {
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.setMinimumDismissTimeInterval(1.5)
        SVProgressHUD.setBackgroundColor(UIColor(r: 0, g: 0, b: 0, a: 0.3))
    }
}


