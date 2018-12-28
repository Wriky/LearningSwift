//
//  UIColor+Extension.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/12/20.
//  Copyright © 2018 wangyuan. All rights reserved.
//

import UIKit

extension UIColor {
    public convenience init(r: CGFloat, g: CGFloat, b:CGFloat, a:CGFloat = 1) {
        self.init(red: r / 255.0, green: r/255.0, blue: b/255.0, alpha: a)
    }
    
    //hex color
    public convenience init?(hexString: String, alpha:CGFloat = 1.0) {
        var formated = hexString.replacingOccurrences(of: "0x", with: "")
        formated = formated.replacingOccurrences(of: "#", with: "")
        
        if let hex = Int(formated, radix: 16) {
            let red = CGFloat(CGFloat((hex & 0xFF0000) >> 16)/255.0)
            let green = CGFloat(CGFloat((hex & 0x00FF00) >> 8)/255.0)
            let blue = CGFloat(CGFloat((hex & 0x0000FF) >> 0)/255.0)
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        } else {
            return nil
        }
    }
    
    //gray
    public convenience init(gray: CGFloat, alpha:CGFloat = 1) {
        self.init(red: gray/255, green: gray/255, blue: gray/255, alpha: alpha)
    }
    
    
    //random
    public static func random(randomAlpha: Bool = false) -> UIColor {
        let randomRed = CGFloat.random(in: 0...1)
        let randomGreen = CGFloat.random(in: 0...1)
        let randomBlue = CGFloat.random(in: 0...1)
        let alpha = randomAlpha ? CGFloat.random(in: 0...1) : 1.0
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: alpha)
    }
    
    /// 背景灰色 f8f9f7
    class func globalBackgroundColor() -> UIColor {
        return UIColor(r: 248, g: 249, b: 247)
    }
    
    /// 背景红色
    class func globalRedColor() -> UIColor {
        return UIColor(r: 196, g: 73, b: 67)
    }
    
    /// 字体蓝色
    class func blueFontColor() -> UIColor {
        return UIColor(r: 72, g: 100, b: 149)
    }
    
    /// 背景灰色 132
    class func grayColor132() -> UIColor {
        return UIColor(r: 132, g: 132, b: 132)
    }
    
    /// 背景灰色 232
    class func grayColor232() -> UIColor {
        return UIColor(r: 232, g: 232, b: 232)
    }
    
    /// 夜间字体背景灰色 113
    class func grayColor113() -> UIColor {
        return UIColor(r: 113, g: 113, b: 113)
    }
    
    /// 夜间背景灰色 37
    class func grayColor37() -> UIColor {
        return UIColor(r: 37, g: 37, b: 37)
    }
    
    /// 灰色 210
    class func grayColor210() -> UIColor {
        return UIColor(r: 210, g: 210, b: 210)
    }

}
