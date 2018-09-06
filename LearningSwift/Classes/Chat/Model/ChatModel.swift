//
//  ChatModel.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/9/6.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import HandyJSON


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

struct MessageModel: HandyJSON {
    var msg_id: String = ""
    var content: String = ""
    var msg_type: Int = 1
    var user_id: String = ""
    var channel_code: String = ""
    var channel_type: Int = 1
}
