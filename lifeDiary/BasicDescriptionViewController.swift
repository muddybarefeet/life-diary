//
//  BasicDescriptionViewController.swift
//  lifeDiary
//
//  Created by Anna Rogers on 8/3/16.
//  Copyright © 2016 Anna Rogers. All rights reserved.
//

import UIKit

class BasicDescriptionViewController: CoreDataTravelLocationViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    var today: Moodlet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded next view", today)
    }
    
}
