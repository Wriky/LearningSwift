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
    public typealias NetworkSuccessHandler = (AnyObject?) -> Void
    public typealias NetworkFailureHandler = (HTTPURLResponse?, AnyObject?, NSError) -> Void

    var manager: SessionManager?
    
    static let shared = NetworkManager()
    
    private override init() {
        super.init()
    }
}

extension NetworkManager {
    func startRequest(_ request: NetworkRequest,
                      _ success: @escaping NetworkSuccessHandler,
                      _ failure: @escaping NetworkFailureHandler) -> (){
        
        guard request.requestURL().count > 0 else {
            #if DEBUGSWIFT
                print("请求路径为空")
            #endif
                failure(nil, nil, NSError())
            return
        }
        
        
    }
}
