//
//  NetworkUtils.swift
//  LearningSwift
//
//  Created by wangyuan on 2019/1/8.
//  Copyright © 2019 wangyuan. All rights reserved.
//

import Foundation

public class NetworkUtils {
    // 生成请求链接
    static func generalUrl(baseUrlStr: String, requestUrlStr: String) -> URL {
        // 判断URL是否完整
        let requsetUrl = URL(string: requestUrlStr)
        if requsetUrl != nil && requsetUrl?.host != nil && requsetUrl?.scheme != nil {
            return requsetUrl!
        }
        
        var url = URL(string: baseUrlStr)
        
        if baseUrlStr.count > 0 && !baseUrlStr.hasSuffix("/") {
            url?.appendPathComponent("")
        }
        return URL(string: requestUrlStr, relativeTo: url)!
    }
    
    // 生产唯一Key
    /*
    static func generateKey(urlStr: String, method: String, params: [String: Any]) -> String {
        let url_md5 = "Url:\(urlStr)".networkMD5()
        let method_md5 = "Method:\(method)".networkMD5()
        
        var params_md5 = ""
        if params.count > 0 {
            let data = try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            params_md5 = String(data: data, encoding: .utf8)!.networkMD5()
        }
        return "\(url_md5)_\(method_md5)_\(params_md5)"
    }
     */
    
    
}
