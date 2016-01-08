//
//  ViewController.swift
//  SecretRoom
//
//  Created by Jo Albright on 6/15/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var myName: String?
    
    var chatMessages: [String:[String:AnyObject]] = [:]
    
    @IBOutlet weak var chatField: UITextField!
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!

    @IBOutlet weak var messagesTableView: UITableView!
    
    // Create a reference to a Firebase location
    var myFirebase = Firebase(url:"https://secret-room.firebaseio.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagesTableView.dataSource = self
        messagesTableView.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
        
        // Read data and react to changes
        myFirebase.observeEventType(.Value, withBlock: {
            snapshot in
            
            if let data = snapshot.value as? [String:AnyObject] {
                
                self.chatMessages = data["messages"] as! [String:[String:AnyObject]]
                
                self.messagesTableView.reloadData()
                
            }
            
            
        })
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return chatMessages.values.array.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("messageCell") as! UITableViewCell
        
        let message = chatMessages.values.array[indexPath.row]
        
        cell.textLabel?.text = message["name"] as? String
        cell.detailTextLabel?.text = message["message"] as? String
        
        return cell
        
    }
    
    @IBAction func saveName(sender: AnyObject) {
        
        myName = chatField.text
        
        chatField.text = ""
        
        nameButton.hidden = true
        messageButton.hidden = false
        
    }
    
    @IBAction func sendMessage(sender: AnyObject) {
        
        let firebaseMessages = myFirebase.childByAppendingPath("messages")
        
        let firebaseMessage = firebaseMessages.childByAutoId()
        
        let message = [
        
            "message" : chatField.text,
            "name" : myName
        
        ]
        
        chatField.text = ""
        
        firebaseMessage.setValue(message)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

