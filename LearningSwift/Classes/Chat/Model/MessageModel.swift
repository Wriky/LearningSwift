//
//  MessageModel.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/11/2.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit
import HandyJSON

class MessageModel: NSObject, HandyJSON {
    public var msg_id: String?
    public var content: String?
    public var msg_type: Int = 1
    public var user_id: String?
    public var channel_code: String?
    public var channel_type: Int = 1
    
    required override init() {
        
    }
    
    class func managedObjectClass() -> AnyClass {
        return NSClassFromString("CoreMessage")!
    }
    
    class func primaryKeys() -> Dictionary<String, String>? {
        return ["msg_id": "msg_id"]
    }
}
