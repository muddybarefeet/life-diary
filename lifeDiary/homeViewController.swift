//
//  homeViewController.swift
//  lifeDiary
//
//  Created by Anna Rogers on 8/3/16.
//  Copyright © 2016 Anna Rogers. All rights reserved.
//

import UIKit

class homeViewController: UIViewController {
    
    @IBOutlet weak var greeting: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    //1. get the user name from the device and display with hello
    //2. set up core data
    //3. set up slider
    //4. make and pass the core data model to the next view controller

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view controller did load")
        //test exact username returned may wan to slice of some of it
        let user = UIDevice.currentDevice().name
        greeting.text = "Hello " + user + "!"
        print("user", user)
    }
    
    @IBAction func more(sender: AnyObject) {
        //on click of the button segue passing the current core data model information to the next page
    }
}
