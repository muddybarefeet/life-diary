//
//  HomeViewController.swift
//  lifeDiary
//
//  Created by Anna Rogers on 8/3/16.
//  Copyright © 2016 Anna Rogers. All rights reserved.
//

import UIKit
import CoreData

//TODO: remove duplcate code making UIComponents

class HomeViewController: CoreDataViewController, UITextViewDelegate {
    
    @IBOutlet weak var greeting: UILabel!
    @IBOutlet weak var nextOrDone: UIButton!

    
    var today: Moodlet?
    var mood: Float?
    
    let Quote = TheySaidSoQuoteClient.sharedInstance
    
    let app = UIApplication.sharedApplication().delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        //make sure the today object is empty
        today = nil

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
        
        //1. determine the time of day
        let hour = NSCalendar.currentCalendar().component(.Hour, fromDate: NSDate()) //return the int representing the hour
        
        let user = UIDevice.currentDevice().name
        
        let data = app.entries
        let fetchRequest = NSFetchRequest(entityName: "Moodlet")
        //order by created at - first on being the latest added
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "created_at", ascending: false)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: data.context, sectionNameKeyPath: nil, cacheName: nil)
        let calendar: NSCalendar = NSCalendar.currentCalendar()
        let entities = fetchedResultsController!.fetchedObjects as! [Moodlet]
        let lastSavedTime = entities[0].created_at
        
        if hour < 12 {
            greeting.text = "Good Morning " + user
            
            //if has something saved for both today and yesterday
            if calendar.isDateInToday(lastSavedTime!) && calendar.isDateInYesterday(entities[1].created_at!) {
                nextOrDone.hidden = true
                
                print("have a today and yesterday and it it morning")
                //1. Then show goal if have one else just show random quote
                today = entities[0]
                
                //TODO: QUOTE
                
                let label:UILabel = UILabel(frame: CGRectMake(0,-150, self.view.bounds.size.width, self.view.bounds.size.height));
                label.textAlignment = NSTextAlignment.Center;
                label.numberOfLines = 0;
                label.font = UIFont.systemFontOfSize(16.0);
                label.text = "TODO: Prompt/reminder about how you wanted your day to be a good day"
                self.view.addSubview(label);
                
            } else if calendar.isDateInYesterday(lastSavedTime!) {
                print("yesterday and it it morning")
                today = nil
                nextOrDone.setTitle("Done", forState: .Normal)
                //TODO: make a key on the model to store this data point
                let label:UILabel = UILabel(frame: CGRectMake(0,-150, self.view.bounds.size.width, self.view.bounds.size.height));
                label.textAlignment = NSTextAlignment.Center;
                label.numberOfLines = 0;
                label.font = UIFont.systemFontOfSize(16.0);
                label.text = "Take one minute to think about today. What can you do to make today a good day?"
                self.view.addSubview(label);
                
                let textView: UITextView = UITextView(frame: CGRectMake(0,300, self.view.bounds.size.width, 100))
                textView.delegate = self
                textView.textAlignment = NSTextAlignment.Center
                self.view.addSubview(textView);
                
            } else {
                print("no today or yesterday saved")
                //neither were saved show slider for yesterday and ask about goal
                nextOrDone.setTitle("Done", forState: .Normal)
                //make and display question and slider and the how would today be good question
                let label:UILabel = UILabel(frame: CGRectMake(0,-150, self.view.bounds.size.width, self.view.bounds.size.height));
                label.textAlignment = NSTextAlignment.Center;
                label.numberOfLines = 0;
                label.font = UIFont.systemFontOfSize(16.0);
                label.text = "How did yesterday shape up to be?"
                self.view.addSubview(label);
                //if yesterday was the last day saved: then ask about goal for day
                let slider = UISlider(frame:CGRectMake(self.view.bounds.size.width/7, 260, 280, 20))
                slider.minimumValue = 0
                slider.maximumValue = 100
                slider.continuous = true
                slider.tintColor = UIColor.redColor()
                slider.value = 50
                
                slider.addTarget(self, action: #selector(HomeViewController.setSliderValue), forControlEvents: .ValueChanged)
                self.view.addSubview(slider)
                
                let label2:UILabel = UILabel(frame: CGRectMake(0, -20, self.view.bounds.size.width, self.view.bounds.size.height));
                label2.textAlignment = NSTextAlignment.Center;
                label2.numberOfLines = 0;
                label2.font = UIFont.systemFontOfSize(16.0);
                label2.text = "Take one minute to think about today. What can you do to make today a good day?"
                self.view.addSubview(label2);
                
                let textView: UITextView = UITextView(frame: CGRectMake(0,400, self.view.bounds.size.width, 100))
                textView.delegate = self
                textView.textAlignment = NSTextAlignment.Center
                self.view.addSubview(textView);

            }
            
        } else if hour >= 12 && hour <= 17 {
            nextOrDone.hidden = true
            greeting.text = "Good Afternoon " + user
            //if there is an object saved for today
            if calendar.isDateInToday(lastSavedTime!) {
                print("afternoon and have a today object")
                //if there is a goal set then show something about this
                Quote.getInspirationalQuote() { (data, error) in
                    print("getting results")
                    if error == nil {
                        print("results-----todo")
                    } else {
                       print("error", error)
                    }
                }
            } else {
                //just show quote
                print("afternoon and no today obj")
                
            }
            
        } else {
            nextOrDone.setTitle("Next", forState: .Normal)
            greeting.text = "Good Evening " + user
            //if there is an object saved for today
            if calendar.isDateInToday(lastSavedTime!) {
                print("evening and there is a today obj")
                //TODO: MOVE TO NEXT PAGE if there was a goal set then asked it that was achieved
                today = entities[0]
            } else {
                print("evening and no today obj")
                today = nil
            }
        }
        
    }
    
    func setSliderValue (sender:UISlider!) {
        print("slider clicked")
       //mood = slider.value
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

    //    @IBAction func mood (sender: AnyObject) {
//        print("slider", slider)
//        mood = slider.value
//        //view.backgroundColor = UIColor(hue: 0.15, saturation: 1, brightness: 1, alpha: CGFloat(mood!))
//    }
    
    //if there has already been a today obj defined then just update the value
//    @IBAction func nextPage (sender: AnyObject) {
//        //store the object in core data
//        if today != nil {
//            print("updating today",today?.mood)
//            today?.mood = mood
//            print("updating today 2",today?.mood)
//        } else {
//            //TODO: add in the storing of a goal if wanted/need to think on naming/what this is asking
//            today = Moodlet(mood: slider.value, stored_externally: false, context: fetchedResultsController!.managedObjectContext)
//        }
//        performSegueWithIdentifier("descriptionPage1", sender: nil)
//    }
    
    //coords passed to the new controller
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
//        if segue.identifier == "descriptionPage1" {
//            let controller = segue.destinationViewController as! BasicDescriptionViewController
//            controller.today = today
//        }
//    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        print("started typing")
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            // tell the textView to resign being first responder, which will also hide the keyboard
            textView.resignFirstResponder()
            // Don't allow textView to insert a LF into its text property
            return false
        }
        var newText: NSString
        newText = textView.text!
        newText = newText.stringByReplacingCharactersInRange(range, withString: text)
        return true
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        return true
    }
    
}


