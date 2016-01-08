//
//  ViewController.swift
//  My Data
//
//  Created by Jo Albright on 9/2/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var appD = UIApplication.sharedApplication().delegate as AppDelegate
        
        var entity = NSEntityDescription.entityForName("Post", inManagedObjectContext: appD.managedObjectContext)
        
        var postObject = NSEntityDescription.insertNewObjectForEntityForName("Post", inManagedObjectContext: appD.managedObjectContext) as NSManagedObject
        
        postObject.setValue("jo@theironyard.com", forKey: "user")
        postObject.setValue("this is a cool title", forKey: "title")
        
//        appD.saveContext()
        
        ///// fetch
        
        var fetchRequest = NSFetchRequest()
        
        fetchRequest.entity = entity
        
        var predicate = NSPredicate(format: "user = 'jo@theironyard.com'")
        fetchRequest.predicate = predicate
        
        var sortDescriptor = NSSortDescriptor(key: "posted_at", ascending: true)

        fetchRequest.sortDescriptors = [sortDescriptor]
        
        var fetchedObjects = appD.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil)
        
        println(fetchedObjects)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

