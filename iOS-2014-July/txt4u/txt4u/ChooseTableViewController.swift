//
//  ChooseTableViewController.swift
//  txt4u
//
//  Created by Jo Albright on 9/10/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

import UIKit

class ChooseTableViewController: FriendsTableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        var friendQuery = PFUser.query()
        friendQuery.findObjectsInBackgroundWithBlock { (users:[AnyObject]!, error: NSError!) -> Void in
            
            self.friends = users as [PFUser]
            self.tableView.reloadData()
            
        }
        
    }
    
    
    @IBAction func cancelChoice(sender: AnyObject) {
        
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        println((self.navigationController?.presentingViewController as UINavigationController).viewControllers[0])
        
        var myOldFriends = ((self.navigationController?.presentingViewController as UINavigationController).viewControllers[0] as FriendsTableViewController).friends

        var presentingNavC = self.navigationController?.presentingViewController as UINavigationController
        
        var friendsTVC = presentingNavC.viewControllers[0] as FriendsTableViewController
        
        friendsTVC.friends += [friends[indexPath.row]]
        
        var user = PFUser.currentUser()
        user["friends"] = friendsTVC.friends
        user.saveInBackground()
        
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
