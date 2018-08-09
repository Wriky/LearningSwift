//
//  Enums.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/8/9.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import Foundation

enum ChatToolBarStatus: String {
    
    case ChatToolBarStatusNothing = "Nothing"     // 默认状态
    case ChatToolBarStatusShowVoice = "ShowVoice"  // 录音状态
    case ChatToolBarStatusShowFace = "ShowFace"    // 输入表情状态
    case ChatToolBarStatusShowMore = "ShowMore"    // 显示“更多”页面状态
    case ChatToolBarStatusShowKeyboard = "ShowKeyboard"// 正常键盘
    case ChatToolBarStatusShowVideo = "ShowVideo"   // 录制视频
}
