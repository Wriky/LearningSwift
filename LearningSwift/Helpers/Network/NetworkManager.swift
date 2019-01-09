//
//  NetworkManager.swift
//  LearningSwift
//
//  Created by wangyuan on 2019/1/3.
//  Copyright © 2019 wangyuan. All rights reserved.
//

import UIKit
import Alamofire


class NetworkManager: NSObject {
    //成功回调
    public typealias NetworkSuccessHandler = (AnyObject?) -> Void
    
    //失败回调
    public typealias NetworkFailureHandler = (NSError) -> Void

    
    /// 进行请求
    public func startRequest(request: NetworkRequest, success: NetworkSuccessHandler, failure: NetworkFailureHandler) {
        
    }
    
   
}

extension NetworkManager {
    
}
