//
//  Note+CoreDataClass.swift
//  Notes with Core Data
//
//  Created by Riley Evans on 10/29/18.
//  Copyright © 2018 Riley Evans. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Note)
public class Note: NSManagedObject {
    
    var date: Date? {
        get {return dateCreated as Date?}
        set {dateCreated = newValue as NSDate?}
    }
    
    convenience init?(title: String?, body: String?, date: Date?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return nil
        }
        
        self.init(entity: Note.entity(), insertInto: managedContext)
        self.title = title
        self.body = body
        self.date = date
        
    }
}
