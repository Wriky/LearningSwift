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
    public func startRequest(requestEntity: NetworkRequest,
                             success: NetworkSuccessHandler?,
                             failure: NetworkFailureHandler?) -> DataRequest {
        
        
        let urlStr: URLConvertible = BaseUrl + requestEntity.requestURL()
        let method: HTTPMethod = requestEntity.requestHttpMethod()
        let parameters: [String: Any] = requestEntity.requestParameters()!
        let encoding: ParameterEncoding = requestEntity.requestParameterEncoding()
        let headers = requestEntity.requestHeaderFieldValueDictionary()
   
        let request = Alamofire.request(urlStr, method: method, parameters: parameters, encoding: encoding, headers: headers)
        
        request.responseJSON { (response) in
          
            if response.result.isSuccess {
                if let value = response.result.value {
                    let json = JSON(value)
                    
                }
                
            }
            
            
//            if let error = response.error {
//                failure?(error as NSError)
//            } else {
//                if let value = response.result.value {
//                    let json = JSON(value)
//                    guard json["message"] == "success" else { return }
//                    guard let datas = json["data"].array else { return }


//                    completionHandler(pullTime, datas.compactMap({
//                        NewsModel.deserialize(from: $0["content"].string)
//                    }))
//                }
//
//                success?(response.data as AnyObject)
//            }
        }
        return request
    }
   
}

extension NetworkManager {
    
}
