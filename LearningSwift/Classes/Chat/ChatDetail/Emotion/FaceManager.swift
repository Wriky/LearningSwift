//
//  FaceManager.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/8/14.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit
import HandyJSON

class FaceManager: NSObject {
    
   static var emojiEmotions: NSArray = []
   static var customEmotions: NSArray = []
   static var gifEmotions: NSArray = []

    class func emojiEmotion() -> NSArray {
        
        if emojiEmotions.count > 0 {
            return emojiEmotions
        }
        let path: String = Bundle.main.path(forResource: "emoji.plist", ofType: nil)!
        
        let pathArr = NSArray(contentsOfFile: path)
        emojiEmotions = [WYEmotion].deserialize(from: pathArr)! as NSArray
        return emojiEmotions
    }
    
    class func customEmotion() -> NSArray {
        if customEmotions.count > 0 {
            return customEmotions
        }
        let path: String = Bundle.main.path(forResource: "normal_face.plist", ofType: nil)!
        let pathArr = NSArray(contentsOfFile: path)
        customEmotions = [WYEmotion].deserialize(from: pathArr)! as NSArray
        
        return customEmotions
    }
    
    class func gifEmotion() -> NSArray {
        if gifEmotions.count > 0 {
            return gifEmotions
        }
        let path: String = Bundle.main.path(forResource: "normal_face.plist", ofType: nil)!
        let pathArr = NSArray(contentsOfFile: path)
        gifEmotions = [WYEmotion].deserialize(from: pathArr)! as NSArray
        
        return gifEmotions
    }
    
    class func transferMessageToEmoji(message: String, font: UIFont, lineHeight:CGFloat) {
        
    }
}
