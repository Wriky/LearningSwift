//
//  NetworkHelper.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/7/4.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


protocol NetworkHelperProtocol {
    //获取新闻列表数据
    static func loadNewsFeeds(category: NewsTitleCategory, ttFrom: TTFrom, _ completionHandler: @escaping (_ maxBehotTime: TimeInterval, _ news: [NewsModel]) -> ())
    
    //获取更多新闻列表数据
    static func loadMoreNewsFeeds(category: NewsTitleCategory, ttFrom: TTFrom, maxBehotTime: TimeInterval, listCount: Int, _ completionHandler: @escaping (_ news: [NewsModel]) -> ())

    //获取好友列表
    static func loadFriendsList( _ completionHandler: @escaping (_ friendsList: [FriendModel]) -> ())
    
    //获取历史聊天记录
    static func loadMessageHistory(_ channelCode: String, _ completionHandler: @escaping (_ messageList: [MessageModel]) -> ())
    
    //发送聊天消息
    static func sendMessageInfo(_ content: String ,_ channelCode: String, _ completionHandler: @escaping(_ messageList: MessageModel) -> ())
}

extension NetworkHelperProtocol {
    
    static func loadNewsFeeds(category: NewsTitleCategory, ttFrom: TTFrom, _ completionHandler: @escaping (_ maxBehotTime: TimeInterval, _ news: [NewsModel]) -> ()) {
        
        let pullTime = Date().timeIntervalSince1970
        let url = BaseUrl + "/api/news/feed/v75/?"
        let params = ["device_id": device_id,
                      "count": 20,
                      "list_count": 15,
                      "category": category.rawValue,
                      "min_behot_time": pullTime,
                      "strict": 0,
                      "detail": 1,
                      "refresh_reason": 1,
                      "tt_from": ttFrom,
                      "iid": iid] as [String: Any]
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else { return }
            
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { return }
                guard let datas = json["data"].array else { return }
                completionHandler(pullTime, datas.compactMap({
                    NewsModel.deserialize(from: $0["content"].string)
                }))
            }
        }
    }
    
    static func loadMoreNewsFeeds(category: NewsTitleCategory, ttFrom: TTFrom, maxBehotTime: TimeInterval, listCount: Int, _ completionHandler: @escaping (_ news: [NewsModel]) -> ()) {
        
        let url = BaseUrl + "/api/news/feed/v75/?"
        let params = ["device_id": device_id,
                      "count": 20,
                      "list_count": listCount,
                      "category": category.rawValue,
                      "min_behot_time": maxBehotTime,
                      "strict": 0,
                      "detail": 1,
                      "refresh_reason": 1,
                      "tt_from": ttFrom,
                      "iid": iid] as [String: Any]
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else { return }
            
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { return }
                guard let datas = json["data"].array else { return }
                completionHandler(datas.compactMap({
                    NewsModel.deserialize(from: $0["content"].string)
                }))
            }
        }
    }
    
    static func loadFriendsList( _ completionHandler: @escaping (_ friendsList: [FriendModel]) -> ()) {
        let url = "http://wd-api.h2he.cn/v1/friends/approved?"
        let authToken = "Bearer Y9QuivZhTDqa-So8DeGBwA"
        let params = ["user_id":"10"]
        let header: HTTPHeaders = ["Authorization": authToken,
                                   "Accept": "application/json"]
        Alamofire.request(url, parameters: params, headers: header).responseJSON { (response) in
            guard response.result.isSuccess else { return }

            if let value = response.result.value {
                let json = JSON(value)
                guard json.error == nil else {return}
                
                guard let datas = json["response"].array else {return}
                
                print("resultData + \(datas)")
                
                completionHandler(datas.compactMap({ data in
                    FriendModel.deserialize(from: data.description)
                }))
            }
        }
    }
    
    static func loadMessageHistory(_ channelCode: String, _ completionHandler: @escaping (_ messageList: [MessageModel]) -> ()) {
        let url = "http://wd-api.h2he.cn/v1/messages/history?"
        let params: [String : Any] = ["channel_code": channelCode,
                      "per_page": 30,
                      "page": 1,
                      "last_msg_id": 0,
                      "client_msg_id": 0]

        let authToken = "Bearer Y9QuivZhTDqa-So8DeGBwA"
        let header: HTTPHeaders = ["Authorization": authToken,
                                   "Accept": "application/json"]
        Alamofire.request(url, parameters: params, headers: header).responseJSON { (response) in
            guard response.result.isSuccess else {return}
            
            if let value = response.result.value {
                let json = JSON(value)
                guard json.error == nil else {return}
                
                guard let responseDic = json["response"].dictionary else {return}
                
                guard let datas = responseDic["messages"]?.array else {return}
                
                completionHandler(datas.reversed().compactMap({data in
                    MessageModel.deserialize(from: data.description)
                }))
            }
        }
    }
    
    static func sendMessageInfo(_ content: String ,_ channelCode: String, _ completionHandler: @escaping(_ messageList: MessageModel) -> ()) {
        let url = "http://wd-api.h2he.cn/v1/messages?"
        let params: [String : Any] = ["channel_code": channelCode,
                                      "channel_type": 2,
                                      "content": content,
                                      "tag": "1536205342730493",
                                      "msg_type": 1,
                                      "user_id": 10,
                                      "target_id": 11]
        
        let authToken = "Bearer Y9QuivZhTDqa-So8DeGBwA"
        let header: HTTPHeaders = ["Authorization": authToken,
                                   "Accept": "application/json"]
        Alamofire.request(url, method: .post , parameters: params, encoding:JSONEncoding.default, headers: header).responseJSON { (response) in
            guard response.result.isSuccess else {return}
            
            if let value = response.result.value {
                let json = JSON(value)
                guard json.error == nil else {return}
                
                guard let responseDic = json["response"].dictionary else {return}
                guard let messageDic = responseDic["message"]?.dictionary else {return}

                completionHandler(
                    MessageModel.deserialize(from: messageDic)!
                )
            }
        }
    }
}

struct NetworkHelper: NetworkHelperProtocol {
    
}

