//
//  CentrifugeHelper.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/8/23.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit
import CentrifugeiOS

class CentrifugeHelper: NSObject {
    var client: CentrifugeClient!

    let channel = "jsfiddle-chat"
    let user = "ios-swift"
    let secret = "secret"

    
    func configCentrifuge() {
        let timestamp = "\(Int(Date().timeIntervalSince1970))"
        let token = Centrifuge.createToken(string: "\(user)\(timestamp)", key: secret)
        let creds = CentrifugeCredentials(token: token, user: user, timestamp: timestamp)
        let url = "wss://centrifugo.herokuapp.com/connection/websocket"
        
        client = Centrifuge.client(url: url, creds: creds, delegate: self as! CentrifugeClientDelegate)
        
    }
}
