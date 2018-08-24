//
//  Alert.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/8/24.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit

class Alert: NSObject {
    class func showError(_ error: Any) {
        showAlert("Error", message: "\(error)")
    }
    
    class func showAlert(_ title: String, message: String) {
        let vc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "Close", style: .cancel) { _ in
            vc.dismiss(animated: true, completion: nil)
        }
        vc.addAction(close)
        
        let currentVC =  BaseViewController.currentViewController()
        currentVC?.show(vc, sender: self)
    }
    
    class func showMessage(_ message: CentrifugeServerMessage) {
        showAlert("Message", message: "\(message)")
    }
    
    class func showResponse(_ message: CentrifugeServerMessage?, error: Error?) {
        if let msg = message {
            showMessage(msg)
        } else {
            showError(error!)
        }
    }
}
