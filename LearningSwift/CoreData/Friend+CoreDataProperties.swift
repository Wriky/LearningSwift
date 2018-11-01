//
//  Friend+CoreDataProperties.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/11/1.
//  Copyright © 2018年 wangyuan. All rights reserved.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var contact_id: String?
    @NSManaged public var id: String?
    @NSManaged public var state: String?
    @NSManaged public var target_id: String?
    @NSManaged public var user_id: String?
    @NSManaged public var channel: Channel?
    @NSManaged public var user: User?

}
