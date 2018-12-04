//
//  FriendEntity.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/11/2.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit

class FriendEntity: NSObject {
    public var ID: String?
    public var state: String?
    public var target_id: String?
    public var user_id: String?
    public var contact_id: String?
    public var user: UserEntity?
    public var channel: ChannelEntity?
    
    class func managedObjectClass() -> AnyClass {
        return NSClassFromString("CoreFriend")!
    }
    
    class func oneToOneRelationship() -> Dictionary<String, String>? {
        return ["user": "friend", "channel": "friend"]
    }
    
}
