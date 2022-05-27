//
//  CoreDataGroup+CoreDataProperties.swift
//  VkClient-2
//
//  Created by Денис Сизов on 27.05.2022.
//
//

import Foundation
import CoreData


extension CoreDataGroup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataGroup> {
        return NSFetchRequest<CoreDataGroup>(entityName: "CoreDataGroup")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var image: String?
    @NSManaged public var isMember: Int16

}

extension CoreDataGroup : Identifiable {

}
