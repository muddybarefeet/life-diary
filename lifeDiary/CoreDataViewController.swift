//
//  CoreDataViewController.swift
//  lifeDiary
//
//  Created by Anna Rogers on 8/3/16.
//  Copyright © 2016 Anna Rogers. All rights reserved.
//

import UIKit
import CoreData

class CoreDataViewController: UIViewController {
    
    var fetchedResultsController : NSFetchedResultsController?{
        didSet{
            executeSearch()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func executeSearch(){
        if let fetchController = fetchedResultsController{
            do{
                try fetchController.performFetch()
            }catch let error as NSError{
                print("Error while trying to perform a search: \n\(error)\n\(fetchedResultsController)")
            }
        }
    }
    
}
