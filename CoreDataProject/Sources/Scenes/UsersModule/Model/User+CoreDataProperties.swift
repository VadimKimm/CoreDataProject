//
//  User+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Vadim Kim on 14.08.2022.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var avatar: Data?
    @NSManaged public var birthDate: Date?
    @NSManaged public var gender: String?
    @NSManaged public var name: String?

}

extension User : Identifiable {

}
