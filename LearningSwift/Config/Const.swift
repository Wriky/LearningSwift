//
//  Const.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/7/3.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit


//服务器地址
public let BaseUrl = "https://is.snssdk.com"

//屏幕宽度
public let kScreenWidth = UIScreen.main.bounds.size.width

//屏幕高度
public let kScreenHeight = UIScreen.main.bounds.size.height

//状态栏高度
public let kStatusBarHeight: CGFloat = 20

//底部导航栏高度
public let kTabBarHeight: CGFloat = 49

//导航栏高度
public let kNavBarHeight: CGFloat = 64

//聊天ToolBar高度
public let kChatBarHeight: CGFloat = 215

public let kNight = "Night"

public let isIphoneX: Bool = (kScreenWidth == 812)


public func RGBA(_ r: CGFloat,_ g: CGFloat,_ b: CGFloat,_ a:CGFloat) -> UIColor {
    return UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: a)
}

public func RGBASame(_ r: CGFloat,_ a: CGFloat) -> UIColor {
    return RGBA(r, r, r, a)
}

public func RGB(_ r: CGFloat,_ g: CGFloat,_ b: CGFloat) -> UIColor {
    return RGBA(r, g, b, 1)
}

public func RGBSame(_ r: CGFloat) -> UIColor {
    return RGBA(r, r, r, 1)
}


