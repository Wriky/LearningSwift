//
//  NewsModel.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/8/27.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import HandyJSON

struct MediaInfo: HandyJSON {
    var avatar_url: String = ""
    var follow: Bool = false
    var is_star_user: Bool = false
    var name: String = ""
}

struct NewsModel: HandyJSON {
    var abstract: String = ""
    var title: String = ""
    var description = ""
    var media_info: MediaInfo?
}



