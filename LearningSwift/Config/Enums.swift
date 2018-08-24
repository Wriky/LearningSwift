//
//  Enums.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/8/9.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import Foundation

enum ChatToolBarStatus: String {
    
    case Nothing = "Nothing"     // 默认状态
    case ShowVoice = "ShowVoice"  // 录音状态
    case ShowFace = "ShowFace"    // 输入表情状态
    case ShowMore = "ShowMore"    // 显示“更多”页面状态
    case ShowKeyboard = "ShowKeyboard"// 正常键盘
    case ShowVideo = "ShowVideo"   // 录制视频
}

enum EmotionMenuButtonType: Int {
    case Emoji = 100
    case Custom = 101
    case Gif = 102
} 

public enum CentrifugeMethod: String {
    case connect = "connect"
    case disconnect = "disconnect"
    case subscribe = "subscribe"
    case unsubscribe = "unsubscribe"
    case publish = "publish"
    case presence = "presence"
    case history = "history"
    case join = "join"
    case leave = "leave"
    case message = "message"
    case refresh = "refresh"
    case ping = "ping"
}
