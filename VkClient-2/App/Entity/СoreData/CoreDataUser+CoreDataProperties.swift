//
//  CoreDataUser+CoreDataProperties.swift
//  VkClient-2
//
//  Created by Денис Сизов on 27.05.2022.
//
//

import Foundation
import CoreData


extension CoreDataUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataUser> {
        return NSFetchRequest<CoreDataUser>(entityName: "CoreDataUser")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var image: String?

}

extension CoreDataUser : Identifiable {

}
