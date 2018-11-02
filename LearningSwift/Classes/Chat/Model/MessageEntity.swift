//
//  MessageEntity.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/11/2.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit

class MessageEntity: NSObject {
    public var msg_id: String?
    public var content: String?
    public var msg_type: Int = 1
    public var user_id: String?
    public var channel_code: String?
    public var channel_type: Int = 1
    
    class func managedObjectClass() -> AnyClass {
        return NSClassFromString("CoreMessage")!
    }
    
}
