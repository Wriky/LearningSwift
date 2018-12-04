//
//  CoreDataClassInfo.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/11/2.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit

enum CDPropertyType: Int {
    case CDPropertyTypeUnknown = 0
    case CDPropertyTypeVoid
    case CDPropertyTypeBool
    case CDPropertyTypeInt8
    case CDPropertyTypeUInt8
    case CDPropertyTypeInt16
    case CDPropertyTypeUInt16
    case CDPropertyTypeInt32
    case CDPropertyTypeUInt32
    case CDPropertyTypeInt64
    case CDPropertyTypeUInt64
    case CDPropertyTypeFloat
    case CDPropertyTypeDouble
    case CDPropertyTypeLongDouble
    case CDPropertyTypeArray
    case CDPropertyTypeCustomObject
    case CDPropertyTypeFoundationObject
}

class CoreDataPropertyInfo: NSObject {
    
    required override init() {
        
    }
    
    class func propertyWithProperty(property: objc_property_t) -> Self {
        
        return self.init()
    }
}

class CoreDataClassInfo: NSObject {
    required override init() {
        
    }
    
    class func classInfoWith(cls: AnyClass, ignoreProperties: Array<Any>, replacePropertyKeypaths: Dictionary<String, String>) -> Self {
        
        return self.init()
    }
    
}
