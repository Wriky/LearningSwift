//
//  NewsModel.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/8/27.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import HandyJSON

struct NewsModel: HandyJSON {
    var abstract: String = ""
    var title: String = ""
    var description = ""
}


struct UserModel: HandyJSON {
    var nick_name: String = ""
    var mobile: String = ""
    var id: String = ""
    var gender: Int = 1
}

struct ChannelModel: HandyJSON {
    var ID: String = ""
    var code: String = ""
    var resource_id = ""
    var resource_type = ""
}

struct FriendModel: HandyJSON {
    var ID: String = ""
    var state: String = ""
    var target_id: String = ""
    var user_id: String = ""
    var contact_id: String = ""
    var user: UserModel?
    var channel: ChannelModel?
}
