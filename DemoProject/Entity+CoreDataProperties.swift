//
//  Entity+CoreDataProperties.swift
//  
//
//  Created by Frog Pepe on 27/06/2022.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var name: String?

}
