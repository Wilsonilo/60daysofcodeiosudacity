//
//  Note+CoreDataProperties.swift
//  CoolNotes
//
//  Created by Wilson Muñoz on 9/29/17.
//  Copyright © 2017 Wilson Muñoz. All rights reserved.
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note");
    }

    @NSManaged public var text: String?
    @NSManaged public var creationDate: Date?
    @NSManaged public var notebook: Notebook?

}
