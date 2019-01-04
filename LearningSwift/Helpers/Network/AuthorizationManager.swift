//
//  AuthorizationManager.swift
//  LearningSwift
//
//  Created by wangyuan on 2019/1/3.
//  Copyright © 2019 wangyuan. All rights reserved.
//

import Foundation
import Alamofire

public class AuthorizationManager: SessionManager {
    public typealias NetworkSuccessHandler = (AnyObject?) -> Void
    public typealias NetworkFailureHandler = (HTTPURLResponse?, AnyObject?, NSError) -> Void
    
    private typealias CachedTask = (HTTPURLResponse?, AnyObject?, NSError?) -> Void
    
    private var cachedTasks = Array<CachedTask>()
    private var isRefreshing = false
    
    @discardableResult
    public func startRequest(
        method: HTTPMethod,
        URLString: URLConvertible,
        parameters: [String: AnyObject]?,
        encoding: ParameterEncoding,
        success: NetworkSuccessHandler?,
        failure: NetworkFailureHandler?)-> DataRequest?
    {
        let cachedTask: CachedTask = { [weak self] URLResponse, data, error in
            guard let strongSelf = self else { return }
            
            if let error = error {
                failure?(URLResponse, data, error)
            } else {
            strongSelf.startRequest(
                    method: method,
                    URLString: URLString,
                    parameters: parameters,
                    encoding: encoding,
                    success: success,
                    failure: failure
                )
            }
        }
        
        if self.isRefreshing {
            self.cachedTasks.append(cachedTask)
            return nil
        }
        
       let request = self.request(URLString, method: method, parameters: parameters, encoding: encoding, headers: nil)
        
        // Append your auth tokens here to your parameters
       request.response {[weak self] (response) in
        guard let strongSelf = self else { return }

            if let subResponse = response.response, subResponse.statusCode == 401 {
                strongSelf.cachedTasks.append(cachedTask)
                strongSelf.refreshTokens()
                return
            }
            
            if let error = response.error {
                failure?(response.response, response.data as AnyObject, error as NSError)
            } else {
                success?(response.data as AnyObject)
            }
        }
        
        return request
    }
    
    func refreshTokens() {
        self.isRefreshing = true
        
        // Make the refresh call and run the following in the success closure to restart the cached tasks
        let cachedTaskCopy = self.cachedTasks
        self.cachedTasks.removeAll()
        for task in cachedTaskCopy {
            task(nil, nil, nil)
        }        
        self.isRefreshing = false
    }
}
