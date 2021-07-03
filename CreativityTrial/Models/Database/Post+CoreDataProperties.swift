//
//  Post+CoreDataProperties.swift
//  CreativityTrial
//
//  Created by Olajide Osho on 03/07/2021.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var body: String?
    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var userId: Int32

}

extension Post : Identifiable {

}
