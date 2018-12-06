//
//  EmotionModel.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/12/6.
//  Copyright © 2018 wangyuan. All rights reserved.
//

import UIKit
import HandyJSON

class EmotionModel: NSObject, HandyJSON {

    public var face_name: String?
    public var face_id: String?
    public var code: String?
    public var type: String?

    required override init() {
        
    }
    
}
