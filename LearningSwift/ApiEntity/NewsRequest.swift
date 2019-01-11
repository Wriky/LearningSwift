//
//  NewsRequest.swift
//  LearningSwift
//
//  Created by wangyuan on 2019/1/8.
//  Copyright © 2019 wangyuan. All rights reserved.
//

import UIKit

class NewsRequest: NetworkRequest {
    
    var category: NewsTitleCategory?
    var tt_From: TTFrom?
    var pullTime: TimeInterval?
    var listCount: Int?

    init(category: NewsTitleCategory, ttFrom: TTFrom, pullTime: TimeInterval, listCount: Int) {
        self.category = category
        self.tt_From = ttFrom
        self.pullTime = pullTime
        self.listCount = listCount
    }
    
    override func baseURL() -> String {
       return "https://is.snssdk.com"
    }
    
    override func requestURL() -> String {
        return "/api/news/feed/v75/?"
    }
    
    override func requestParameters() -> [String : Any]? {

        return ["device_id": device_id,
                "count": 20,
                "list_count": listCount as Any,
                "category": category!.rawValue,
                "min_behot_time": pullTime!,
                "strict": 0,
                "detail": 1,
                "refresh_reason": 1,
                "tt_from": tt_From!,
                "iid": iid] as [String: Any]
    }
   
}


