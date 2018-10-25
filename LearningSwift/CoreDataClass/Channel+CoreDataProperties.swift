//
//  Channel+CoreDataProperties.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/10/24.
//  Copyright © 2018年 wangyuan. All rights reserved.
//
//

import Foundation
import CoreData


extension Channel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Channel> {
        return NSFetchRequest<Channel>(entityName: "Channel")
    }

    @NSManaged public var code: String?
    @NSManaged public var resource_id: String?
    @NSManaged public var resource_type: String?
    @NSManaged public var friend: Friend?

}
