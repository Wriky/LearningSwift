//
//  FriendListRequest.swift
//  LearningSwift
//
//  Created by wangyuan on 2019/1/11.
//  Copyright © 2019 wangyuan. All rights reserved.
//

import UIKit

class FriendListRequest: NetworkRequest {
    
    override func requestURL() -> String {
        return "/v1/friends/approved?"
    }
    
    override func requestParameters() -> [String : Any]? {
        
        return ["user_id":"10"] as [String: Any]
    }
    
    override func requestHeaderFieldValueDictionary() -> Dictionary<String, String>? {
        let authToken = "Bearer Y9QuivZhTDqa-So8DeGBwA"
        return ["Authorization": authToken,
         "Accept": "application/json"]
    }
}
