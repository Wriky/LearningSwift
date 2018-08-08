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
        
        let tabbar = UITabBar.appearance()
        tabbar.theme_tintColor = ["#000", "#898989"]
        tabbar.theme_barTintColor = ["#FFF", "#FFF"]


        addChildViewControllers()
        
    }

    private func addChildViewControllers() {
        setChildViewController(CommunityViewController(), title: "社区", imageName: "home")
        setChildViewController(VideoViewController(), title: "视频", imageName: "video")
        setChildViewController(ChatListViewController(), title: "聊天", imageName: "weitoutiao")
    }
    
    private func setChildViewController(_ childController:UIViewController, title:String, imageName: String) {
        
        if UserDefaults.standard.bool(forKey: kNight) {
            setNightChildController(controller: childController, imageName: imageName)
        } else {
            setDayChildController(controller: childController, imageName: imageName)
        }
        
        childController.title = title
        addChildViewController(BaseNavigationController(rootViewController: childController))
    }
    
    private func setNightChildController(controller: UIViewController, imageName: String) {
        controller.tabBarItem.image = UIImage(named: imageName + "_tabbar_night_32x32_")
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_tabbar_press_night_32x32_")
    }
    
    private func setDayChildController(controller: UIViewController, imageName: String) {
        controller.tabBarItem.image = UIImage(named: imageName + "_tabbar_32x32_")
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_tabbar_press_32x32_")
    }
    
    
}
