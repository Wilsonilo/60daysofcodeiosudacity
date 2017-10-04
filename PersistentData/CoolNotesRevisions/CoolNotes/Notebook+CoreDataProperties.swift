//
//  Notebook+CoreDataProperties.swift
//  CoolNotes
//
//  Created by Wilson Muñoz on 9/29/17.
//  Copyright © 2017 Wilson Muñoz. All rights reserved.
//

import Foundation
import CoreData


extension Notebook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notebook> {
        return NSFetchRequest<Notebook>(entityName: "Notebook");
    }

    @NSManaged public var name: String?
    @NSManaged public var creationDate: Date?
    @NSManaged public var notes: Note?

}
