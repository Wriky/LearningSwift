//
//  ChatDetailViewController.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/8/8.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit

class ChatDetailViewController: BaseViewController {
    var nameStr: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.title = nameStr
        
    }

   

}
