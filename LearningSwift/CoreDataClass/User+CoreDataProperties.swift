//
//  User+CoreDataProperties.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/10/24.
//  Copyright © 2018年 wangyuan. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var gender: Int16
    @NSManaged public var id: String?
    @NSManaged public var mobile: String?
    @NSManaged public var nick_name: String?
    @NSManaged public var friend: Friend?

}
