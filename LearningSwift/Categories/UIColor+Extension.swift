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
}
