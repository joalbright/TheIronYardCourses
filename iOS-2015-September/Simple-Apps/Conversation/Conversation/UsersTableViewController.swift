//
//  UsersTableViewController.swift
//  Conversation
//
//  Created by Jo Albright on 11/3/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import UIKit
import Parse

class UsersTableViewController: UITableViewController {

    var users: [PFUser] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let userQuery = PFUser.query()
        
        if let objectId = PFUser.currentUser()?.objectId {
            
            userQuery?.whereKey("objectId", notEqualTo: objectId)
            
        }
        
        userQuery?.findObjectsInBackgroundWithBlock({ [weak self] (objects, error) -> Void in
            
            if let users = objects as? [PFUser] {
                
                self?.users = users
                self?.tableView.reloadData()
                
            }
            
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return users.count
    
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath)

        cell.textLabel?.text = users[indexPath.row].username

        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // sender is the object that triggered the segue
        // we are guarding to make sure it is a UITableViewCell
        guard let cell = sender as? UITableViewCell else { return }
        
        // we are guarding to make sure it is a ConversationViewController
        // we are also casting to use the "user" property below
        guard let convoVC = segue.destinationViewController as? ConversationViewController else { return }
        
        // get the indexPath from tableView for the cell
        guard let indexPath = tableView.indexPathForCell(cell) else { return }
        
        // use indexPath.row to get the user for that cell
        // setting user on convoVC to be the other person in the conversation
        convoVC.user = users[indexPath.row]
        
    }

}




