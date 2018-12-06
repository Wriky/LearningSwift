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
        emojiEmotions = [EmotionModel].deserialize(from: pathArr)! as NSArray
        return emojiEmotions
    }
    
    class func customEmotion() -> NSArray {
        if customEmotions.count > 0 {
            return customEmotions
        }
        let path: String = Bundle.main.path(forResource: "normal_face.plist", ofType: nil)!
        let pathArr = NSArray(contentsOfFile: path)
        customEmotions = [EmotionModel].deserialize(from: pathArr)! as NSArray
        
        return customEmotions
    }
    
    class func gifEmotion() -> NSArray {
        if gifEmotions.count > 0 {
            return gifEmotions
        }
        let path: String = Bundle.main.path(forResource: "normal_face.plist", ofType: nil)!
        let pathArr = NSArray(contentsOfFile: path)
        gifEmotions = [EmotionModel].deserialize(from: pathArr)! as NSArray
        
        return gifEmotions
    }
    
    class func transferMessageToEmoji(message: String, font: UIFont, lineHeight:CGFloat) -> NSMutableAttributedString {
        let attributeStr = NSMutableAttributedString.init(string: message)
        let regEmj = "\\[[a-zA-Z0-9\\/\\u4e00-\\u9fa5]+\\]"
        let expression = try? NSRegularExpression.init(pattern: regEmj, options: .caseInsensitive)
        if expression == nil {
            return attributeStr
        }
        attributeStr.addAttribute(kCTFontAttributeName as NSAttributedString.Key, value: font, range: NSMakeRange(0, attributeStr.length))
        let resultArray = expression?.matches(in: message, options: .anchored, range: NSMakeRange(0, attributeStr.length))
        let mutableArray: NSMutableArray = NSMutableArray.init(capacity: resultArray!.count)
        
        for match:NSTextCheckingResult in resultArray! {
            let range:NSRange = match.range
            
            let start = message.index(message.startIndex, offsetBy: range.location)
            let end = message.index(message.startIndex, offsetBy: range.location+range.length)
            let subRange = start..<end
            let subStr: String = String(message[subRange])
            
            let faceArray:[EmotionModel] = FaceManager.customEmotion() as! [EmotionModel]
            for face:EmotionModel in faceArray {
                if face.face_name! .elementsEqual(subStr) {
                    let attach: NSTextAttachment = NSTextAttachment()
                    attach.image = UIImage.init(named: face.face_name!)
                    
                    //位置调整Y值
                    attach.bounds = CGRect(x: 0, y: -4, width: lineHeight, height: lineHeight)
                    
                    let imgStr: NSAttributedString = NSAttributedString.init(attachment: attach)
                    let imgDic: NSMutableDictionary = NSMutableDictionary.init(capacity: 2)
                    imgDic.setObject(NSValue.init(range: range), forKey: "range" as NSCopying)
                    imgDic.setObject(imgStr, forKey: "image" as NSCopying)
                    mutableArray.add(imgDic)
                    
                }
            }
        }
        if mutableArray.count > 1 {
            for index in (0...(Int(mutableArray.count-1))).reversed() {
                var indexRange: NSRange = NSMakeRange(0, 0)
                let imgDic:NSMutableDictionary = mutableArray[index] as! NSMutableDictionary
                let imgValue: NSValue = imgDic.value(forKey: "range") as! NSValue
                imgValue.getValue(&indexRange)
                let attributeValue: NSAttributedString = imgDic["range"] as! NSAttributedString
                attributeStr.replaceCharacters(in: indexRange, with: attributeValue)
            }
        }
        
        return attributeStr
    }
}
