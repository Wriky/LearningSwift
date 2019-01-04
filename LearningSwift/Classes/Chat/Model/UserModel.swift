//
//  UserModel.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/11/2.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

class UserModel: NSObject, HandyJSON {
    public var nick_name: String?
    public var mobile: String?
    public var id: String?
    public var gender: Int = 1
    public var friend: FriendModel?

    required override init() {
        
    }
    
    class func managedObjectClass() -> AnyClass {
        return NSClassFromString("CoreUser")!
    }
    
    class func oneToOneRelationship() -> Dictionary<String, String>? {
        return ["friend":"user"]
    }
    
    class func primaryKeys() -> Dictionary<String, String>? {
        return ["id": "id"]
    }
}
