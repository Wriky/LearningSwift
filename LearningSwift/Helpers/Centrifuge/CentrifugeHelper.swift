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
    
    override init() {
        super.init()
        self.configCentrifuge()
    }
    
    func configCentrifuge() {
        let timestamp = "\(Int(Date().timeIntervalSince1970))"
        let token = Centrifuge.createToken(string: "\(user)\(timestamp)", key: secret)
        let creds = CentrifugeCredentials(token: token, user: user, timestamp: timestamp)
        let url = "wss://centrifugo.herokuapp.com/connection/websocket"
        
        client = Centrifuge.client(url: url, creds: creds, delegate: self as CentrifugeClientDelegate)
    }
    
    func publish(_ text: String) {
        client.publish(toChannel: channel, data: ["nick": nickName, "input": text]) { (message, error) in
            print("publish message: \(String(describing: message))")
        }
    }
    
    func showMessage(_ message: CentrifugeServerMessage) {
        Alert.showAlert("Message", message: "\(message)")
    }
    
    func showResponse(_ message: CentrifugeServerMessage?, error: Error?) {
        if let msg = message {
            showMessage(msg)
        } else if let err = error {
           Alert.showError(err)
        }
    }
}

extension CentrifugeHelper : CentrifugeChannelDelegate, CentrifugeClientDelegate {
   
    //MARK: CentrifugeClientDelegate
    func client(_ client: CentrifugeClient, didDisconnectWithError error: Error) {
        Alert.showError(error)
    }

    func client(_ client: CentrifugeClient, didReceiveRefreshMessage message: CentrifugeServerMessage) {
        
        print("didReceiveRefresh message: \(message)")
    }

    
    //MARK: CentrifugeChannelDelegate
    func client(_ client: CentrifugeClient, didReceiveMessageInChannel channel: String, message: CentrifugeServerMessage) {
        if let data = message.body?["data"] as? [String : AnyObject], let input = data["input"] as? String, let nick = data["nick"] as? String {
            print("didReceiveMessageInChannel:"+"\(nick) && \(input) && \(channel)")
        }
    }

    func client(_ client: CentrifugeClient, didReceiveJoinInChannel channel: String, message: CentrifugeServerMessage) {
        if let data = message.body?["data"] as? [String : AnyObject], let user = data["user"] as? String {
            print("\(message.method.rawValue) && \(user)")
        }
    }

    func client(_ client: CentrifugeClient, didReceiveLeaveInChannel channel: String, message: CentrifugeServerMessage) {
        if let data = message.body?["data"] as? [String : AnyObject], let user = data["user"] as? String {
            print("didReceiveLeaveInChannel:\(message.method.rawValue) && \(user)")
        }
    }

    func client(_ client: CentrifugeClient, didReceiveUnsubscribeInChannel channel: String, message: CentrifugeServerMessage) {
        print("didReceiveUnsubscribeInChannel \(message)"   )
    }
}

extension CentrifugeHelper {
    func connectClient() {
        self.client.connect(withCompletion: self.showResponse)
    }
    
    func disconnectClient() {
        self.client.disconnect()
    }
    
    func pingClient() {
        self.client.ping(withCompletion: self.showResponse)
    }
    
    func subscribeClient() {
        self.client.subscribe(toChannel: self.channel, delegate: self, completion: self.showResponse)
    }
    
    func unsubscibeClient() {
        self.client.unsubscribe(fromChannel: self.channel, completion: self.showResponse)
    }
    
    func clientHistory() {
        self.client.history(ofChannel: self.channel, completion: self.showResponse)
    }
    
    func presenceClient() {
        self.client.history(ofChannel: self.channel, completion: self.showResponse)
    }
}




