//
//  CompletionViewController.swift
//  lifeDiary
//
//  Created by Anna Rogers on 8/4/16.
//  Copyright © 2016 Anna Rogers. All rights reserved.
//

import UIKit

class CompletionViewController: CoreDataViewController {
    
    var today: Moodlet?
    
    
    override func viewDidLoad() {
        self.navigationItem.hidesBackButton = true
    }
    
    
    @IBAction func home(sender: AnyObject) {
        //return to the home page where 
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
}
