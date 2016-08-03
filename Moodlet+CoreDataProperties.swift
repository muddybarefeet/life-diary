//
//  Moodlet+CoreDataProperties.swift
//  lifeDiary
//
//  Created by Anna Rogers on 8/3/16.
//  Copyright © 2016 Anna Rogers. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Moodlet {

    @NSManaged var mood: NSNumber?
    @NSManaged var latitude: NSNumber?
    @NSManaged var created_at: NSDate?
    @NSManaged var longitude: NSNumber?
    @NSManaged var text: String?
    @NSManaged var long_text: String?
    @NSManaged var photo: NSData?
    @NSManaged var temperatureF: NSNumber?
    @NSManaged var weather_summary: String?
    @NSManaged var stored_externally: NSNumber?

}
