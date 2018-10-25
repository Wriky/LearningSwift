//
//  MainTabBarController.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/7/3.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTabChildViewControllers()
        
    }

    private func addTabChildViewControllers() {
        setChildViewController(NewsViewController(), title: "新闻", imageName: "home")
        setChildViewController(VideoViewController(), title: "视频", imageName: "video")
        setChildViewController(ChatListViewController(), title: "聊天", imageName: "weitoutiao")
    }
    
    private func setChildViewController(_ childController:UIViewController, title:String, imageName: String) {
        
        childController.title = title
        childController.tabBarItem.image = UIImage.init(named: imageName + "_tabbar_32x32_")
        childController.tabBarItem.selectedImage = UIImage.init(named: imageName + "_tabbar_press_32x32_")
    childController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: UIControl.State.selected)
        
        addChild(BaseNavigationController(rootViewController: childController))
    }
    
}
