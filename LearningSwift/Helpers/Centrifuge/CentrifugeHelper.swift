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
 
    let user = "ios-swift"
    let secret = "secret"

    override init() {
        super.init()
        self.configCentrifuge()
    }
    
    func configCentrifuge() {
//        let timestamp = "\(Int(Date().timeIntervalSince1970))"
//        let token = Centrifuge.createToken(string: "\(user)\(timestamp)", key: secret)
//        let creds = CentrifugeCredentials(token: token, user: user, timestamp: timestamp)
//        let url = "wss://centrifugo.herokuapp.com/connection/websocket"
        
        let timestamp = "1536114461"
        let token = "65204e66e1512911dc10a830c941f690a14c8c7629e3c3d6cb3aecf76bae65d0"
        let creds = CentrifugeCredentials(token: token, user: "10", timestamp: timestamp)
        let url = "ws://wd-api.h2he.cn:8000/connection/websocket"
        
        client = Centrifuge.client(url: url, creds: creds, delegate: self as CentrifugeClientDelegate)
    }
    
    func publish(_ nickName: String, _ text: String, _ channelCode: String) {
        
        let messageDic: [String : Any] =  ["nick": nickName,
                                           "input": ["channel_code": channelCode,
                                                     "content":text,
                                                     "user_id":10,
                                                     "msg_type":1]]
        
        client.publish(toChannel: channelCode, data: messageDic) { (message, error) in
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
        if let data = message.body?["data"] as? [String : AnyObject], let input = data["input"] as? [String: Any], let text = input["content"] as? String , let nick = data["nick"] as? String {
            print("didReceiveMessageInChannel:"+"\(nick) && \(text) && \(channel)")
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
    
    func subscribeClient(_ channelCode: String) {
        self.client.subscribe(toChannel: channelCode, delegate: self, completion: self.showResponse)
    }
    
    func unsubscibeClient(_ channelCode: String) {
        self.client.unsubscribe(fromChannel: channelCode, completion: self.showResponse)
    }
    
    func clientHistory(_ channelCode: String) {
        self.client.history(ofChannel: channelCode, completion: self.showResponse)
    }
    
    func presenceClient(_ channelCode: String) {
        self.client.presence(inChannel: channelCode, completion: self.showResponse)
    }
}




