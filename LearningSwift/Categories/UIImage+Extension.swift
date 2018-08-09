//
//  UIImage+Extension.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/8/9.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func fillImageWithColor(color: UIColor) -> UIImage {
        let rect: CGRect = CGRect.init(x: 0, y: 0, width: 1, height: 1)
        let context: CGContext =  UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        return image
    }
}
