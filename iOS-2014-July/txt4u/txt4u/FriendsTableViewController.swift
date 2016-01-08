//
//  FriendsTableViewController.swift
//  txt4u
//
//  Created by Jo Albright on 9/10/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    var friends: [PFUser] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        println(NSStringFromClass(self.classForCoder))
        
//        NSStringFromClass(self.classForCoder)
//        reflect(self).summary
        
//        println(reflect(self).summary)
//        println(__FILE__.lastPathComponent)
        
        if reflect(self).summary == "Messages.FriendsTableViewController" {
            
//            println(PFUser.currentUser())
            
            if PFUser.currentUser()["friends"] != nil {
                
                var queryMe = PFUser.query()
                queryMe.whereKey("username", equalTo: PFUser.currentUser().username)
                queryMe.includeKey("friends")
                
                queryMe.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
                    
//                    println(objects)
                    self.friends = objects[0]["friends"] as [PFUser]
                    self.tableView.reloadData()
                    
                }
                
            }
            
            var nc = NSNotificationCenter.defaultCenter()
            nc.addObserverForName("newMessage", object: nil, queue: NSOperationQueue.mainQueue(), usingBlock: { (notification: NSNotification!) -> Void in
                
                // make friend have a different color if with unread message
                
            })
            
        }
        
        
                
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
//        println(self.friends)
        
        self.tableView.reloadData()
        
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return friends.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("friendCell", forIndexPath: indexPath) as UITableViewCell

        var friend = friends[indexPath.row] as PFUser
        
        cell.textLabel?.text = friend.username
        
        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "showConversation" {
            
            var messageVC = segue.destinationViewController as MessageViewController
            
            messageVC.friend = friends[self.tableView.indexPathForCell(sender as UITableViewCell)!.row]
            
        }
        
    }

}
