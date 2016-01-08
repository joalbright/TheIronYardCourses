//
//  ViewController.swift
//  CoreList
//
//  Created by Jo Albright on 2/24/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

// Labwork : 

// - make the cell show the created date
// - change color of cell background based on time since creation [green,yellow,red]
// - add fetch predicate & sortdescriptor to order based on creation date ... oldest first
// - make background grey and text white if completed
// - tap cell to toggle completed

// Bonus :

// - create 2 sections [non-completed,completed]

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var itemNameField: UITextField!
    
    @IBAction func saveItem(sender: AnyObject) {
        
        let applicationDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        var postObject = NSEntityDescription.insertNewObjectForEntityForName("Items", inManagedObjectContext: applicationDelegate.managedObjectContext!) as NSManagedObject
        
        postObject.setValue(itemNameField.text, forKey: "name")
        postObject.setValue(NSDate(), forKey: "created")
        postObject.setValue(false, forKey: "completed")
        
        applicationDelegate.saveContext()
        
        dismissViewControllerAnimated(true, completion: nil)
        
        // save item to core data
        
    }
    
    @IBAction func cancelItem(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

