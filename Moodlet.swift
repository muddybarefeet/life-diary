//
//  Moodlet.swift
//  lifeDiary
//
//  Created by Anna Rogers on 8/3/16.
//  Copyright © 2016 Anna Rogers. All rights reserved.
//

import Foundation
import CoreData


class Moodlet: NSManagedObject {

    convenience init(mood: Float, stored_externally: Bool, context : NSManagedObjectContext){
        
        if let ent = NSEntityDescription.entityForName("Moodlet", inManagedObjectContext: context){
            self.init(entity: ent, insertIntoManagedObjectContext: context)
            self.mood = mood
            self.stored_externally = stored_externally
            self.created_at = NSDate()
        } else {
            fatalError("Unable to find Entity name!")
        }
        
    }
    
    var humanReadableAge : String{
        get {
            let fmt = NSDateFormatter()
            fmt.timeStyle = .NoStyle
            fmt.dateStyle = .ShortStyle
            fmt.doesRelativeDateFormatting = true
            fmt.locale = NSLocale.currentLocale()
            return fmt.stringFromDate(created_at!)
        }
    }


}
