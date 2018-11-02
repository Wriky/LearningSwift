//
//  CoreChannel+CoreDataProperties.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/11/2.
//  Copyright © 2018年 wangyuan. All rights reserved.
//
//

import Foundation
import CoreData


extension CoreChannel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreChannel> {
        return NSFetchRequest<CoreChannel>(entityName: "CoreChannel")
    }

    @NSManaged public var code: String?
    @NSManaged public var resource_id: String?
    @NSManaged public var resource_type: String?
    @NSManaged public var friend: CoreFriend?

}
