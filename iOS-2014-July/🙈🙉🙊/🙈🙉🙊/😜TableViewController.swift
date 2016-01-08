//
//  😜TableViewController.swift
//  🙈🙉🙊
//
//  Created by Jo Albright on 9/9/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

import UIKit

class 😜TableViewController: UITableViewController {

//    var letters: [String]!
    var users:[String:[String]] = [
        "A":["Arthur"],
        "D":["Daniel"],
        "E":["Eric S","Eric W"],
        "H":["Heidi"],
        "J":["Jaime","Jeremy","Jo","Josh"],
        "K":["Kalson","Katlyn"],
        "M":["Merritt"],
        "N":["Nick"],
        "R":["Rene"],
        "S":["Shane","Steve"]
    ]
    
    var letters:[String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        letters = users.keys.array.sorted(<)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        
        return letters.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        var key = letters[section]
        var usersInSection = users[key]
        
        return usersInSection!.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath) as UITableViewCell

        var key = letters[indexPath.section]
        var usersInSection = users[key]
        
        cell.textLabel?.text = usersInSection![indexPath.row]
        
        println(usersInSection![indexPath.row] + " row:\(indexPath.row) section:\(indexPath.section)")
        
        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var headerView = UIView(frame: CGRectMake(0, 0, self.tableView.frame.size.width, 20))
        
        headerView.backgroundColor = UIColor(white: 0.0, alpha: 0.3)
        
        var label = UILabel(frame: CGRectMake(15, 5, 200, 10))
        label.text = letters[section]
        label.textColor = UIColor.whiteColor()
        
        headerView.addSubview(label)
        
        return headerView
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
