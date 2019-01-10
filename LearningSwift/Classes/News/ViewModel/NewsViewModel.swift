//
//  NewsViewModel.swift
//  LearningSwift
//
//  Created by wangyuan on 2019/1/9.
//  Copyright © 2019 wangyuan. All rights reserved.
//

import UIKit

class NewsViewModel: NSObject {
    class func requestNewsData(category: NewsTitleCategory, ttFrom: TTFrom, success: @escaping NetworkSuccessHandler, failure: @escaping NetworkFailureHandler) {
        let pullTime = Date().timeIntervalSince1970

        let request = NewsRequest.init(category: category, ttFrom: ttFrom, pullTime: pullTime)
        
        let manager = NetworkManager()
        manager.startRequest(requestEntity: request, success: { (response) in
            success(response)
        }) { (error) in
            failure(error)
        }
        
    }
}
