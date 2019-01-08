//
//  NetworkCache.swift
//  LearningSwift
//
//  Created by wangyuan on 2019/1/8.
//  Copyright © 2019 wangyuan. All rights reserved.
//

import Foundation
// 缓存
public class NetworkCache {
    
    static let shared = NetworkCache()
    
    let cache = NSCache<NSString, CacheRecord>()
    
    class CacheRecord {
        /// 存储内容
        var content: Any
        /// 最新时间
        var lastTime: Date
        /// 存储时间
        var duration: TimeInterval
        /// 是否过期
        var isOutdate: Bool {
            let timeInterval: TimeInterval = Date().timeIntervalSince(self.lastTime)
            return timeInterval > duration
        }
        
        /// 创建
        init(content: Any, duration: TimeInterval) {
            self.content = content
            self.duration = duration
            self.lastTime = Date()
        }
        /// 更新
        func update(content: Any, duration: TimeInterval) {
            self.content = content
            self.duration = duration
            self.lastTime = Date()
        }
    }
    // 写入
    func writeCache(identifier: String, conetnt: Any, duration: TimeInterval) {
        let key = NSString(string: identifier)
        if let record = self.cache.object(forKey: key) {
            record.update(content: conetnt, duration: duration)
        } else {
            let key = NSString(string: identifier)
            let record = CacheRecord(content: conetnt, duration: duration)
            self.cache.setObject(record, forKey: key)
        }
    }
    
    // 读取
    func readCache(identifier: String) -> Any? {
        let key = NSString(string: identifier)
        var data: Any? = nil
        if let record = self.cache.object(forKey: key) {
            if record.isOutdate {
                self.cache.removeObject(forKey: key)
            } else {
                data = record.content
            }
        }
        return data
    }
}
