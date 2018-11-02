//
//  ChannelEntity.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/11/2.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit

class ChannelEntity: NSObject {
    public var ID: String?
    public var code: String?
    public var resource_id:String?
    public var resource_type:String?
    public var friend: FriendEntity?

    class func managedObjectClass() -> AnyClass {
        return NSClassFromString("CoreChannel")!
    }
    
    class func oneToOneRelationship() -> Dictionary<String, String>? {
        return ["friend":"user"]
    }
}
