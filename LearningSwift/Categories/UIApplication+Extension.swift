//
//  UIApplication+Extension.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/12/29.
//  Copyright © 2018 wangyuan. All rights reserved.
//

import Foundation

extension UIApplication {
    //Run a block in background after app resigns activity
    public func runInBackground(_ closure: @escaping () -> Void, expirationHandler:(() -> Void)? = nil) {
        DispatchQueue.main.async {
            let taskID: UIBackgroundTaskIdentifier
            if let expirationHandler = expirationHandler {
                taskID = self.beginBackgroundTask(expirationHandler: expirationHandler)
            } else {
                taskID = self.beginBackgroundTask(expirationHandler: {})
            }
            closure()
            self.endBackgroundTask(taskID)
        }
    }
    
    //Get the top most view controller from the base view controller; default param is window's rootViewController
    public class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
            if let nav = base as? UINavigationController {
                return topViewController(nav.visibleViewController)
            }
            
            if let tab = base as? UITabBarController {
                if let selected = tab.selectedViewController {
                    return topViewController(selected)
                }
            }
            
            if let presented = base?.presentedViewController {
                return topViewController(presented)
            }
        return base
    }
}
