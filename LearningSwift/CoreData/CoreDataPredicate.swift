//
//  CoreDataPredicate.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/11/2.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit

class CoreDataPredicate: NSObject {
    
    var equalKeys: Dictionary<String, String>?
    var containKeys: Dictionary<String, String>?
    
    class func predicateWithEqualProperties(properties: Array<String>) -> CoreDataPredicate {
        return self.predicateWithEqualProperties(equalPropeties: properties, containProperties: [])
    }
    
    class func predicateWithContainProperties(properties: Array<String>) -> CoreDataPredicate {
        return self.predicateWithEqualProperties(equalPropeties: [], containProperties: properties)
    }
    
    class func predicateWithEqualProperties(equalPropeties: Array<String>, containProperties: Array<String>) -> CoreDataPredicate {
        let predicate: CoreDataPredicate = CoreDataPredicate()
        let equalDic = Dictionary(uniqueKeysWithValues: zip(equalPropeties, equalPropeties))
        predicate.equalKeys = equalDic
        let containDic = Dictionary(uniqueKeysWithValues: zip(containProperties, containProperties))
        predicate.containKeys = containDic
        return predicate
    }
    
    class func predicateWithEqualKeys(equalKeys: Dictionary<String, String>) -> CoreDataPredicate{
        let predicate: CoreDataPredicate = CoreDataPredicate()
        predicate.equalKeys = equalKeys
        return predicate
    }
    
    class func predicateWithContainKeys(containKeys: Dictionary<String, String>) -> CoreDataPredicate {
        let predicate: CoreDataPredicate = CoreDataPredicate()
        predicate.containKeys = containKeys
        return predicate
    }
    
    class func predicateWithEqualKays(equalKeys: Dictionary<String, String>, containKeys: Dictionary<String, String>) -> CoreDataPredicate {
        let predicate: CoreDataPredicate = CoreDataPredicate()
        predicate.equalKeys = equalKeys
        predicate.containKeys = containKeys
        return predicate
    }
    
    func setEqualProperties(equalProperties: Array<String>) {
        let equalDic = Dictionary(uniqueKeysWithValues: zip(equalProperties, equalProperties))
        self.setEqualKeys(equalKeys: equalDic, containKeys: [:])
    }
    
    func setContainProperties(containProperties: Array<String>) {
        let containDic = Dictionary(uniqueKeysWithValues: zip(containProperties, containProperties))
        self.setEqualKeys(equalKeys: [:], containKeys: containDic)
    }
    
    func setEqualProperties(equalProperties: Array<String>, containProperties: Array<String>) {
        let equalDic = Dictionary(uniqueKeysWithValues: zip(equalProperties, equalProperties))
        let containDic = Dictionary(uniqueKeysWithValues: zip(containProperties, containProperties))
        self.setEqualKeys(equalKeys: equalDic, containKeys: containDic)
    }
    
    func setEqualKeys(equalKeys: Dictionary<String, String>, containKeys: Dictionary<String, String>) {
        if equalKeys.count > 0 {
            let equalDic: Dictionary<String, String> = self.equalKeys!
            self.equalKeys = equalDic.merging(equalKeys, uniquingKeysWith: {(_, last) in last})
        }
        
        if containKeys.count > 0 {
            let containDic: Dictionary<String, String> = self.containKeys!
            self.containKeys = containDic.merging(containKeys, uniquingKeysWith: {(_, last) in last})
        }
    }
    
    func makePredicateWithObject(object: [AnyHashable: Any]) -> NSPredicate {
        var predicate: NSPredicate?
        
        if (self.equalKeys?.count)! > 0 {
            var keyArray: Array = [String]()
            var argumentArray: Array = [String]()
            
            for (objectKey, managedObjectKey) in self.equalKeys! {
                keyArray.append("%K = %@")
                
                argumentArray.append(managedObjectKey)
                argumentArray.append(object[objectKey] as! String)
                
            }
            let formatStr: String = keyArray.joined(separator: "&&")
            predicate = NSPredicate(format: formatStr, argumentArray: argumentArray)
        }
        return predicate!
    }
    
    
    func makePredicateWithObjects(objects: Array<[AnyHashable: Any]>) -> NSPredicate {
        var predicate: NSPredicate?
        if objects.count > 0 {
            var keyArray: Array = [String]()
            var argumentArray: Array = [String]()
            var object: [AnyHashable: Any] = objects.first!
            if (self.equalKeys?.count)! > 0 {
                for (objectKey, managedObjectKey) in self.equalKeys! {
                    keyArray.append("%K = %@")
                    
                    argumentArray.append(managedObjectKey)
                    argumentArray.append(object[objectKey] as! String)
                }
            }
            let formatStr: String = keyArray.joined(separator: "&&")
            predicate = NSPredicate(format: formatStr, argumentArray: argumentArray)
        }
        return predicate!
    }
    
   class func makePredicateWithObjects(objects: Array<[AnyHashable: Any]>, equalProperties: Array<String>, containProperties: Array<String>) -> NSPredicate {
        
        let predicate: CoreDataPredicate = CoreDataPredicate.predicateWithEqualProperties(equalPropeties: equalProperties, containProperties: containProperties)
        return predicate.makePredicateWithObjects(objects: objects)
    }
    
    func identifierWithKeys(keys: Array<String>, object: [AnyHashable : Any]) -> String {
        
        if keys.count > 0 {
            if keys.count > 1 {
                let keysArray: NSArray = keys as NSArray
                let sortedArray = keysArray.sortedArray { (obj1, obj2) -> ComparisonResult in
                    let obj1Str = obj1 as! String
                    let obj2Str = obj2 as! String
                    return obj1Str.compare(obj2Str)
                }
                
                var identifier: String?
                for (key, _) in sortedArray.enumerated() {
                    let objectStr = object[key] as! String
                
                    identifier?.append(objectStr + ":")
                }
                return identifier!
            }
        }
        return ""
    }
}
