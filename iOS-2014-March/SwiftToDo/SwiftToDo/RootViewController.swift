//
//  RootViewController.swift
//  SwiftToDo
//
//  Created by Jo Albright on 6/12/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController, UITextFieldDelegate {

    var dinosaurs = ["Stegosaurus","TRex","Velociraptor"]
    
    var inputField = UITextField(frame: CGRectMake(10, 10, 200, 40))
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
//        self.tableView.editing = true
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        var inputForm = UIView(frame: CGRectMake(0, 0, 320, 60))
        
        inputField.delegate = self
        inputField.placeholder = "New Input"
        
        inputForm.addSubview(inputField)
        
        var inputButton = UIButton(frame: CGRectMake(220, 10, 90, 40))
        
        inputButton.setTitle("Add New", forState: UIControlState.Normal)
        inputButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        inputButton.addTarget(self, action: "addNew", forControlEvents: UIControlEvents.TouchUpInside)
        
        inputForm.addSubview(inputButton)
        
        self.tableView.tableHeaderView = inputForm
    }
    
    func addNew()
    {
        if inputField.text == "" {
            return
        }
        
        dinosaurs.insert(inputField.text, atIndex: 0)
        
        inputField.text = ""
        
        self.tableView.reloadData()
        
        inputField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool
    {
        addNew()
        
        return true
    }
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return dinosaurs.count
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        var cell = UITableViewCell()
        
        cell.textLabel.text = dinosaurs[indexPath.row]
        cell.contentView.backgroundColor = UIColor.greenColor()
        
        return cell
    }
    
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!)
    {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            dinosaurs.removeAtIndex(indexPath.row)
            
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    override func tableView(tableView: UITableView!, moveRowAtIndexPath sourceIndexPath: NSIndexPath!, toIndexPath destinationIndexPath: NSIndexPath!)
    {
        var movedItem = dinosaurs[sourceIndexPath.row]
        dinosaurs.removeAtIndex(sourceIndexPath.row)
        dinosaurs.insert(movedItem, atIndex: destinationIndexPath.row)
    }
    
    override func prefersStatusBarHidden() -> Bool { return true }
}