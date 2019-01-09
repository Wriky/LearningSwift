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
    
    init(category: NewsTitleCategory, ttFrom: TTFrom) {
        self.category = category
        self.tt_From = ttFrom
    }
    
    override func requestURL() -> String {
        return "/api/news/feed/v75/?"
    }
    
    override func requestParameters() -> [String : Any]? {
        let pullTime = Date().timeIntervalSince1970

        return ["device_id": device_id,
                "count": 20,
                "list_count": 15,
                "category": category!.rawValue,
                "min_behot_time": pullTime,
                "strict": 0,
                "detail": 1,
                "refresh_reason": 1,
                "tt_from": tt_From!,
                "iid": iid] as [String: Any]
    }
   
}
