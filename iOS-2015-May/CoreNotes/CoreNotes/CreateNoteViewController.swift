//
//  CreateNoteViewController.swift
//  CoreNotes
//
//  Created by Jo Albright on 6/23/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit
import CoreData

// 3
// add a category relationship for the new note

// Hard Mode
// add a textfield and button 
// add tags comma seperated for the new note

var appDelegate: AppDelegate = {
    
    return UIApplication.sharedApplication().delegate as! AppDelegate
    
}()

//var moc: NSManagedObjectContext? = {
//
//    return (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
//    
//}()

class CreateNoteViewController: UIViewController {

    @IBOutlet weak var noteTextField: UITextField!
    
    @IBAction func createNote(sender: AnyObject) {
        
        if let moc = appDelegate.managedObjectContext {
            
            
            let catEntity = NSEntityDescription.entityForName("Category", inManagedObjectContext: moc)
            
            let request = NSFetchRequest()
            
            request.entity = catEntity
            
            if let catObjects = moc.executeFetchRequest(request, error: nil) as? [NSManagedObject] {
                
                
                var newObject = NSEntityDescription.insertNewObjectForEntityForName("Note", inManagedObjectContext: moc) as! NSManagedObject
                
                newObject.setValue(noteTextField.text, forKey: "content")
                newObject.setValue(NSDate(), forKey: "created")
                
                let catObject = catObjects[0]
                
                newObject.setValue(catObject, forKey: "category")
                
                
            }
            
            
            appDelegate.saveContext()
            
            dismissViewControllerAnimated(true, completion: nil)
            
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
