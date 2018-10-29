//
//  Note+CoreDataProperties.swift
//  Notes with Core Data
//
//  Created by Riley Evans on 10/29/18.
//  Copyright © 2018 Riley Evans. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var title: String?
    @NSManaged public var dateCreated: NSDate?
    @NSManaged public var body: String?

}
