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

    convenience init(mood: Float, stored_externally: Bool, text: String, context : NSManagedObjectContext){
        
        if let ent = NSEntityDescription.entityForName("Pin", inManagedObjectContext: context){
            self.init(entity: ent, insertIntoManagedObjectContext: context)
            //self.latitude = lat
            //self.longitude = long
            //long_text
            //weather_summary
            //temperatureF
            //photo
            self.mood = mood
            self.stored_externally = stored_externally
            self.text = text
            self.created_at = NSDate()
        }else{
            fatalError("Unable to find Entity name!")
        }
        
    }
    
    var humanReadableAge : String{
        get{
            let fmt = NSDateFormatter()
            fmt.timeStyle = .NoStyle
            fmt.dateStyle = .ShortStyle
            fmt.doesRelativeDateFormatting = true
            fmt.locale = NSLocale.currentLocale()
            return fmt.stringFromDate(created_at!)
        }
    }


}
