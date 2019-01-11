//
//  ChatViewModel.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/9/3.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit
import SwiftyJSON

class ChatViewModel: NSObject {
    
    class func requestFriendList(success: @escaping NetworkSuccessHandler, failure: @escaping NetworkFailureHandler) {
        let request = FriendListRequest()
        NetworkManager.startRequest(requestEntity: request, success: { (response) in
            let responseJson = JSON(response!)
            if let datas = responseJson["response"].array {
                var friendArray: [FriendModel]?
                friendArray = datas.compactMap({ data in
                    FriendModel.deserialize(from: data.description)
                })
                success(friendArray as AnyObject)
            }
        }) { (error) in
            failure(error)
        }
    }
    

}
