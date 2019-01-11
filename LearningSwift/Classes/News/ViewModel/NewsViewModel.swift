//
//  NewsViewModel.swift
//  LearningSwift
//
//  Created by wangyuan on 2019/1/9.
//  Copyright © 2019 wangyuan. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewsViewModel: NSObject {
    class func requestNewsData(category: NewsTitleCategory, ttFrom: TTFrom, pullTime: TimeInterval , success: @escaping NetworkSuccessHandler, failure: @escaping NetworkFailureHandler) {

        let request = NewsRequest.init(category: category, ttFrom: ttFrom, pullTime: pullTime, listCount:15)
        
        NetworkManager.startRequest(requestEntity: request, success: { (response) in
            let responseJson = JSON(response!)
            if let datas = responseJson["data"].array {
                var newsArray: [NewsModel]?
                newsArray = datas.compactMap({
                    NewsModel.deserialize(from: $0["content"].string)
                })
                success(newsArray as AnyObject)
            }            
        }) { (error) in
            failure(error)
        }
    }
    
    class func requestMoreNewsData(category: NewsTitleCategory, ttFrom: TTFrom, pullTime: TimeInterval ,listCount:Int, success: @escaping NetworkSuccessHandler, failure: @escaping NetworkFailureHandler) {
        let request = NewsRequest.init(category: category, ttFrom: ttFrom, pullTime: pullTime, listCount: listCount)
        NetworkManager.startRequest(requestEntity: request, success: { (response) in
            let responseJson = JSON(response!)
            if let datas = responseJson["data"].array {
                var newsArray: [NewsModel]?
                newsArray = datas.compactMap({
                    NewsModel.deserialize(from: $0["content"].string)
                })
                success(newsArray as AnyObject)
            }
        }) { (error) in
            failure(error)
        }
    }
}
