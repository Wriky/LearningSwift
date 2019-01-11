//
//  NetworkConfig.swift
//  LearningSwift
//
//  Created by wangyuan on 2019/1/8.
//  Copyright © 2019 wangyuan. All rights reserved.
//

import Foundation

public class NetworkConfig {
    // Base url
//    var baseUrl: String = "https://is.snssdk.com"
    
    static let shared = NetworkConfig()
    
    /// 配置
    var cacheDuration: TimeInterval = 180.0

}
