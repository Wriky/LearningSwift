//
//  CoreFriend+CoreDataProperties.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/11/2.
//  Copyright © 2018年 wangyuan. All rights reserved.
//
//

import Foundation
import CoreData


extension CoreFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreFriend> {
        return NSFetchRequest<CoreFriend>(entityName: "CoreFriend")
    }

    @NSManaged public var contact_id: String?
    @NSManaged public var id: String?
    @NSManaged public var state: String?
    @NSManaged public var target_id: String?
    @NSManaged public var user_id: String?
    @NSManaged public var channel: CoreChannel?
    @NSManaged public var user: CoreUser?

}
