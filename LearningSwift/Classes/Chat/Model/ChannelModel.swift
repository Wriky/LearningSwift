//
//  ChannelModel.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/11/2.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit
import HandyJSON

class ChannelModel: NSObject, HandyJSON {
    public var ID: String?
    public var code: String?
    public var resource_id:String?
    public var resource_type:String?
    public var friend: FriendModel?

    required override init() {
        
    }
    
    class func managedObjectClass() -> AnyClass {
        return NSClassFromString("CoreChannel")!
    }
    
    class func oneToOneRelationship() -> Dictionary<String, String>? {
        return ["friend":"user"]
    }
    
    class func primaryKeys() -> Dictionary<String, String>? {
        return ["ID": "ID"]
    }

}
