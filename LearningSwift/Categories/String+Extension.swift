//
//  String+Extension.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/8/14.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit


extension String {
    func emoji()->String {
        
        let scanner = Scanner(string: self)
        var result: UInt32 = 0
        scanner.scanHexInt32(&result)
        
        let emojiStr = Character(UnicodeScalar(result)!)
        
      return  String(emojiStr)
    }
    
}
