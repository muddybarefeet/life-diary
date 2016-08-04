//
//  MoreDescriptionViewController.swift
//  lifeDiary
//
//  Created by Anna Rogers on 8/3/16.
//  Copyright © 2016 Anna Rogers. All rights reserved.
//

//TODO:? Do I wan to have the text view at the top and so not squish the page?

import UIKit

class MoreDescriptionViewController: CoreDataViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var today: Moodlet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("more descrption loaded")
        descriptionText.delegate = self
        
        let newBackButton: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: #selector(self.done))
        self.navigationItem.rightBarButtonItem = newBackButton
    }
    
    //once user added more data then save all data and return to home screen
    func done () {
        //TODO: do I want to check with the user if one area is empty?
        today?.long_text = descriptionText.text
        today?.photo = UIImagePNGRepresentation(imageView.image!)!
        do {
            try today?.managedObjectContext?.save()
        } catch {
            print("There was a problem saving the current album to the database")
        }
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func addPhoto(sender: AnyObject) {
        //want to present the UIImage picker or get the user to take a photo
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated:true, completion:nil)
    }
    
    
    //pick an image and display it to the user
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
}

extension MoreDescriptionViewController: UITextViewDelegate {
    
    
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
        newText = descriptionText.text!
        newText = newText.stringByReplacingCharactersInRange(range, withString: text)
        return true
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        print("should be ending!", descriptionText.text)
        return true
    }
    
}
