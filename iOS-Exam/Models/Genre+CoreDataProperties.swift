//
//  Genre+CoreDataProperties.swift
//  
//
//  Created by Bryan Posas on 8/7/23.
//
//

import Foundation
import CoreData


extension Genre {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Genre> {
        return NSFetchRequest<Genre>(entityName: "Genre")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String?

}
