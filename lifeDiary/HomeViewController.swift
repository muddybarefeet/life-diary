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
        print("view controller did load")
        //test exact username returned may wan to slice of some of it
        let user = UIDevice.currentDevice().name
        let deviceID = UIDevice.currentDevice().identifierForVendor!.UUIDString
        greeting.text = "Hello " + user + "!"
        print("user", user, deviceID)
        
        let data = app.entries
        let fetchRequest = NSFetchRequest(entityName: "Moodlet")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "latitude", ascending: true)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: data.context, sectionNameKeyPath: nil, cacheName: nil)
        
    }
    
    //Todo: Could make a dictionary from 0.0 - 1.0 numbers and the color that they are associated and if the slider value is at that number then use that color? Would it be too jittery? To be tested when get to styling (https://github.com/jonhull/GradientSlider)
    @IBAction func mood(sender: AnyObject) {
        mood = slider.value
        //view.backgroundColor = UIColor(hue: 0.15, saturation: 1, brightness: 1, alpha: CGFloat(mood!))
        
    }
    
    @IBAction func more(sender: AnyObject) {
        //store the object in core data
        today = Moodlet(mood: slider.value, stored_externally: false, context: fetchedResultsController!.managedObjectContext)
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
