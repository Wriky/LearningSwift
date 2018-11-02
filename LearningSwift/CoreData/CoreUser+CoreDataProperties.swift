//
//  CoreUser+CoreDataProperties.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/11/2.
//  Copyright © 2018年 wangyuan. All rights reserved.
//
//

import Foundation
import CoreData


extension CoreUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreUser> {
        return NSFetchRequest<CoreUser>(entityName: "CoreUser")
    }

    @NSManaged public var gender: Int16
    @NSManaged public var id: String?
    @NSManaged public var mobile: String?
    @NSManaged public var nick_name: String?
    @NSManaged public var friend: CoreFriend?

}
