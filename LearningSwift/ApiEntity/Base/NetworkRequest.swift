//
//  NetworkRequest.swift
//  LearningSwift
//
//  Created by wangyuan on 2019/1/8.
//  Copyright © 2019 wangyuan. All rights reserved.
//

import Foundation
import Alamofire

class NetworkRequest: NSObject {
    /// 返回数据
    var response: NetworkResponse?    
    
    /// === 子类继承 ===
    //请求链接
    public func requestURL() -> String {
        return ""
    }
    
    //请求参数
    public func requestParameters() -> [String: Any]? {
        return nil
    }
    
    //请求类型
    public func requestHttpMethod() -> HTTPMethod {
        return .get;
    }
    
}
