//
//  BasicDescriptionViewController.swift
//  lifeDiary
//
//  Created by Anna Rogers on 8/3/16.
//  Copyright © 2016 Anna Rogers. All rights reserved.
//

// to think about: do I want to hide the back buttons on the nav bar?
//how to return to the home page/what it should look like?

import UIKit

class BasicDescriptionViewController: CoreDataViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerText: UITextField!
    
    var today: Moodlet?
    
    let textDelegate = TextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        answerText.delegate = textDelegate
        answerText.textAlignment = .Center
        //add logic to assess the question to present to the user:
        //if mood < 0.4 ask why the day was so bad
        //if mood === 0.5 ask why there was nothing great about their day
        //if mood >0.6 ask what was great about today
        guard let today = today else {
            print("topday object not defined")
            return
        }
        if Double(today.mood!) < 0.4 {
            questionLabel.text = "What was so bad about today?"
        } else if Double(today.mood!) >= 0.4 && Double(today.mood!) <= 0.6 {
            questionLabel.text = "What could have been better about your day?"
        } else {
            questionLabel.text = "What was so great about your day?"
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        print("returning to fn!!!!!!")
    }
    
    //save the answer text to the today object and segue
    @IBAction func nextButton(sender: AnyObject) {
        print("sender text", answerText.text)
        if answerText.text == "" {
            displayError("Could not find an answer.")
        } else {
            today?.text = answerText.text
            performSegueWithIdentifier("descriptionPage2", sender: nil)
        }
    }
    
    //pass the today object to the next controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "descriptionPage2" {
            let controller = segue.destinationViewController as! MoreDescriptionViewController
            controller.today = today
        } else if segue.identifier == "returnToRoot" {
            let controller = segue.destinationViewController as! HomeViewController
            controller.today = today
        }
    }
    
    // update object and save before returning to the home page
    @IBAction func doneButton(sender: AnyObject) {
        if answerText.text == "" {
            displayError("Could not find an answer.")
        } else {
            today?.text = answerText.text
            do {
                try today?.managedObjectContext?.save()
            } catch {
                print("There was a problem saving the current album to the database")
            }
            performSegueWithIdentifier("returnToRoot", sender: nil)
        }
    }
    
    // function to display error to the user
    private func displayError (message: String) {
        let alertController = UIAlertController(title: "Note", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction!) in
        }
        alertController.addAction(OKAction)
        NSOperationQueue.mainQueue().addOperationWithBlock {
            self.presentViewController(alertController, animated: true, completion:nil)
        }
    }
    
}

