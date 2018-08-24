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

    var nickName: String {
        get {
            return "anonymous"
        }
    }
    
    func configCentrifuge() {
        let timestamp = "\(Int(Date().timeIntervalSince1970))"
        let token = Centrifuge.createToken(string: "\(user)\(timestamp)", key: secret)
        let creds = CentrifugeCredentials(token: token, user: user, timestamp: timestamp)
        let url = "wss://centrifugo.herokuapp.com/connection/websocket"
        
        client = Centrifuge.client(url: url, creds: creds, delegate: self)
    }
    
    func publish(_ text: String) {
        client.publish(toChannel: channel, data: ["nick": nickName, "input": text]) { (message, error) in
            print("publish message: \(String(describing: message))")
        }
    }
}

extension CentrifugeHelper: CentrifugeChannelDelegate, CentrifugeClientDelegate {
    
    //MARK: CentrifugeChannelDelegate
    func client(_ client: CentrifugeClient, didReceiveMessageInChannel channel: String, message: CentrifugeServerMessage) {
        if let data = message.body?["data"] as? [String : AnyObject], let input = data["input"] as? String, let nick = data["nick"] as? String {
            print("\(nick) && \(input)")
        }
    }
    
    func client(_ client: CentrifugeClient, didReceiveJoinInChannel channel: String, message: CentrifugeServerMessage) {
        if let data = message.body?["data"] as? [String : AnyObject], let user = data["user"] as? String {
            print("\(message.method.rawValue) && \(user)")
        }
    }
    
    func client(_ client: CentrifugeClient, didReceiveLeaveInChannel channel: String, message: CentrifugeServerMessage) {
        if let data = message.body?["data"] as? [String : AnyObject], let user = data["user"] as? String {
            print("\(message.method.rawValue) && \(user)")
        }
    }
    
    func client(_ client: CentrifugeClient, didReceiveUnsubscribeInChannel channel: String, message: CentrifugeServerMessage) {
        print("didRecieveUnsubscibeInChannel \(message)")
    }
    
    //MARK: CentrifugeClientDelegate
    func client(_ client: CentrifugeClient, didReceiveRefreshMessage message: CentrifugeServerMessage) {
        print("didRecieveRefresh message: \(message)")
    }
    
    func client(_ client: CentrifugeClient, didDisconnectWithError error: Error) {
        Alert.showError(error)
    }
    
    
}
