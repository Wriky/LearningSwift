//
//  FaceManager.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/8/14.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit

class FaceManager: NSObject {
//    var emojiEmotionArr:Array<Any>
    
    public func emojiEmotion() -> Array<WYEmotion> {
        let path: String = Bundle.main.path(forResource: "emoji.plist", ofType: nil)!
//        emojiEmotionArr = WYEmotion.
        return []
    }
    
    public func customEmotion() -> Array<WYEmotion> {
        return []
    }
    
    public func gifEmotion() -> Array<WYEmotion> {
        return []
    }
}
