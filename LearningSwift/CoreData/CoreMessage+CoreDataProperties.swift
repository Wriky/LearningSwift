//
//  CoreMessage+CoreDataProperties.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/11/2.
//  Copyright © 2018年 wangyuan. All rights reserved.
//
//

import Foundation
import CoreData


extension CoreMessage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreMessage> {
        return NSFetchRequest<CoreMessage>(entityName: "CoreMessage")
    }

    @NSManaged public var channel_code: String?
    @NSManaged public var channel_type: Int32
    @NSManaged public var content: String?
    @NSManaged public var msg_id: String?
    @NSManaged public var msg_type: Int32
    @NSManaged public var user_id: String?

}
