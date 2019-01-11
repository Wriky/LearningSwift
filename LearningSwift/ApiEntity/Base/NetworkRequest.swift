//
//  NetworkRequest.swift
//  LearningSwift
//
//  Created by wangyuan on 2019/1/9.
//  Copyright © 2019 wangyuan. All rights reserved.
//

import Foundation
import Alamofire

public class NetworkRequest: NSObject {
    
    //服务器地址
    public func baseURL() -> String {
        return BaseUrl
    }
    
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
    
    //请求头
    public func requestHeaderFieldValueDictionary() -> Dictionary<String,String>? {
        return nil
    }
    
    //编码类型
    public func requestParameterEncoding() -> ParameterEncoding {
        return URLEncoding.default
    }
}
