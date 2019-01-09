//
//  FriendModel.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/11/2.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit
import HandyJSON

class FriendModel: NSObject, HandyJSON {
    
    public var ID: String?
    public var state: String?
    public var target_id: String?
    public var user_id: String?
    public var contact_id: String?
    public var user: UserModel?
    public var channel: ChannelModel?
    
    required override init() {
        
    }
    
    class func managedObjectClass() -> AnyClass {
        return NSClassFromString("CoreFriend")!
    }
    
    class func oneToOneRelationship() -> Dictionary<String, String>? {
        return ["user": "friend", "channel": "friend"]
    }
    
    class func primaryKeys() -> Dictionary<String, String>? {
        return ["ID": "ID"]
    }
}
