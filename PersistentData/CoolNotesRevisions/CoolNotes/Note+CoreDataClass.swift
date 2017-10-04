//
//  Note+CoreDataClass.swift
//  CoolNotes
//
//  Created by Wilson Muñoz on 9/29/17.
//  Copyright © 2017 Wilson Muñoz. All rights reserved.
//

import Foundation
import CoreData


public class Note: NSManagedObject {
    
    convenience init(text:String = "New note", context: NSManagedObjectContext) {
        
        if let ent = NSEntityDescription.entity(forEntityName: "Note", in: context) {
            self.init(entity: ent, insertInto: context)
            self.text = text
            self.creationDate = Date()
        } else {
            fatalError("Unable to find Entity name!")
        }
    }
    
   var getReadableDate:String {
        
        get {
            
            let fmt = DateFormatter()
            fmt.dateStyle = .short
            fmt.timeStyle = .none
            fmt.doesRelativeDateFormatting = true
            fmt.locale = Locale.current
            
            return fmt.string(from: creationDate!)
            
        }
        
    }
    
}
