//
//  MoreDescriptionViewController.swift
//  lifeDiary
//
//  Created by Anna Rogers on 8/3/16.
//  Copyright © 2016 Anna Rogers. All rights reserved.
//

//TODO:? Do I wan to have the text view at the top and so not squish the page?

import UIKit

class MoreDescriptionViewController: CoreDataViewController, UITextViewDelegate {
    
    @IBOutlet weak var descriptionText: UITextView!
    
    var today: Moodlet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("more descrption loaded")
        descriptionText.delegate = self
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        print("started typing")
        //descriptionText.text = descriptionText.text
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            // tell the textView to resign being first responder, which will also hide the keyboard
            textView.resignFirstResponder()
            // Don't allow textView to insert a LF into its text property
            return false
        }
        var newText: NSString
        newText = descriptionText.text!
        newText = newText.stringByReplacingCharactersInRange(range, withString: text)
        return true
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        print("should be ending!", descriptionText.text)
        return true
    }
    
    
    @IBAction func addPhoto(sender: AnyObject) {
        //want to present the UIImage picker or get the user to take a photo
        
    }
    
}
