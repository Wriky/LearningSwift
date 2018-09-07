//
//  Message+CoreDataProperties.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/9/7.
//  Copyright © 2018年 wangyuan. All rights reserved.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var channel_code: String?
    @NSManaged public var channel_type: Int32
    @NSManaged public var content: String?
    @NSManaged public var msg_id: String?
    @NSManaged public var msg_type: Int32
    @NSManaged public var user_id: String?

}
