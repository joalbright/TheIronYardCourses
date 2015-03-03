//
//  MasterViewController.swift
//  PushIt
//
//  Created by Jo Albright on 3/2/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var users: [PFUser] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentInstallation = PFInstallation.currentInstallation()
        currentInstallation["userId"] = PFUser.currentUser().objectId
        currentInstallation.saveInBackgroundWithBlock(nil)
        
//        let user = PFUser()
//        
//        user.username = "Mark"
//        user.email = "mark@gmail.com"
//        user.password = "password"
//        
//        user.signUp()
        
        // run a request to get all users from parse
        
        let userQuery = PFUser.query()
        
        userQuery.whereKey("objectId", notEqualTo: PFUser.currentUser().objectId)
        
        userQuery.findObjectsInBackgroundWithBlock { (users, error) -> Void in
            
            if users.count > 0 {
                
                self.users = users as [PFUser]
                
            }
            
            self.tableView.reloadData()
            
        }
        
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath) as UITableViewCell
        
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.username
        
        // add number of messages for user on detail label
        
        return cell
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // pass user to destination controller to get messages
        
        let destinationController = segue.destinationViewController as UINavigationController
        
        let detailTableViewController = destinationController.viewControllers[0] as DetailTableViewController
        
        let cell = sender as UITableViewCell
        
        let indexPath = tableView.indexPathForCell(cell)
        
        detailTableViewController.user = users[indexPath!.row]
        
    }
    
}







