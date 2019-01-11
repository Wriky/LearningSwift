//
//  NetworkManager.swift
//  LearningSwift
//
//  Created by wangyuan on 2019/1/3.
//  Copyright © 2019 wangyuan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//成功回调
public typealias NetworkSuccessHandler = (AnyObject?) -> Void

//失败回调
public typealias NetworkFailureHandler = (NSError) -> Void

public class NetworkManager: NSObject {
   
    /// 进行请求
    @discardableResult
    public class func startRequest(requestEntity: NetworkRequest,
                             success: NetworkSuccessHandler?,
                             failure: NetworkFailureHandler?) -> DataRequest {
        
        
        let urlStr: URLConvertible = requestEntity.baseURL() + requestEntity.requestURL()
        let method: HTTPMethod = requestEntity.requestHttpMethod()
        let parameters: [String: Any] = requestEntity.requestParameters()!
        let encoding: ParameterEncoding = requestEntity.requestParameterEncoding()
        let headers = requestEntity.requestHeaderFieldValueDictionary()
   
        let request = Alamofire.request(urlStr, method: method, parameters: parameters, encoding: encoding, headers: headers)
        
        request.responseJSON { (response) in
          
            if response.result.isSuccess {
                if let value = response.result.value {
                    success?(value as AnyObject)
                } else {
                    failure?(response.error! as NSError)
                }
            } else {
                failure?(response.error! as NSError)

            }
        }
        return request
    }
   
}

extension NetworkManager {
    
}
