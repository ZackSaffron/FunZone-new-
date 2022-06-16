//
//  User+CoreDataProperties.swift
//  FunZone
//
//  Created by Xavier on 6/5/22.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var password: String?
    @NSManaged public var username: String?

}

extension User : Identifiable {

}
