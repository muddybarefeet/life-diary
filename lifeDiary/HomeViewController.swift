//
//  HomeViewController.swift
//  lifeDiary
//
//  Created by Anna Rogers on 8/3/16.
//  Copyright © 2016 Anna Rogers. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: CoreDataViewController {
    
    @IBOutlet weak var greeting: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    var today: Moodlet?
    var mood: Float?
    
    let app = UIApplication.sharedApplication().delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        /*logic:
        1.Get time of day and deduce greeting: morning, afternoon, evening
         Morning:
            - if no yesterday and no today
            - if yesterday and no today
            - if set today and have yesterday
        Afternoon:
            - if today obj
            - if no today obj
        Evening:
            - no today object
            - today object set
        
        */
        
        //get hour
        let hour = NSCalendar.currentCalendar().component(.Hour, fromDate: NSDate()) //return the int representing the hour
        
        let user = UIDevice.currentDevice().name
        
        if hour < 12 {
            greeting.text = "Good Morning " + user
        } else if hour >= 12 && hour <= 17 {
            greeting.text = "Good Afternoon " + user
        } else {
            greeting.text = "Good Evening " + user
        }
        
//        let data = app.entries
//        let fetchRequest = NSFetchRequest(entityName: "Moodlet")
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "latitude", ascending: true)]
//        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: data.context, sectionNameKeyPath: nil, cacheName: nil)
        
    }
    
//    @IBAction func unwindToHome(unwindSegue: UIStoryboardSegue) {
//        //returning to this VC from another page and with the updated today object I wan to 
//        //show label with cutom text depending on what mood like (in the how was your day label)
//        //have an edit button to return to how it was when there was not an object defined
//        if unwindSegue.sourceViewController is BasicDescriptionViewController {
//            print("Coming from Basic")
//            greeting.hidden = true
//        } else if unwindSegue.sourceViewController is MoreDescriptionViewController {
//            print("Coming from More")
//        }
//    }
    
    //Todo: Could make a dictionary from 0.0 - 1.0 numbers and the color that they are associated and if the slider value is at that number then use that color? Would it be too jittery? To be tested when get to styling (https://github.com/jonhull/GradientSlider)
    @IBAction func mood(sender: AnyObject) {
        print("slider", slider)
        mood = slider.value
        //view.backgroundColor = UIColor(hue: 0.15, saturation: 1, brightness: 1, alpha: CGFloat(mood!))
        
    }
    
    //if there has already been a today obj defined then just update the value
    @IBAction func more(sender: AnyObject) {
        //store the object in core data
        if today != nil {
            print("updating today",today?.mood)
            today?.mood = mood
            print("updating today 2",today?.mood)
        } else {
            print("making today")
          today = Moodlet(mood: slider.value, stored_externally: false, context: fetchedResultsController!.managedObjectContext)
        }
        performSegueWithIdentifier("descriptionPage1", sender: nil)
    }
    
    //coords passed to the new controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "descriptionPage1" {
            let controller = segue.destinationViewController as! BasicDescriptionViewController
            controller.today = today
        }
    }
    
    
}
