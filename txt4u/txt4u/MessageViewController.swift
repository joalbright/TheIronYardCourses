//
//  ViewController.swift
//  txt4u
//
//  Created by Jo Albright on 9/10/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

import UIKit

// remove lines in tableview
// make two different bubble colors for messages per user
// have tableview automatically start scrolled to bottom
// show timestamp below message

class MessageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    var formHolder: UIView = UIView(frame: CGRectMake(0, SCREEN_HEIGHT - 60, SCREEN_WIDTH, 60))
    
    var messageField: UITextField = UITextField(frame: CGRectMake(10, 10, SCREEN_WIDTH - 100, 40))
    
    var sendButton: UIButton = UIButton(frame: CGRectMake(SCREEN_WIDTH - 80, 10, 70, 40))
    
    @IBOutlet weak var tableView: UITableView!
    
    var friend: PFUser! {
     
        willSet(user) {
            
//            println("inside will set \(user)")
            
        }
        
        didSet(user) {
            
//            println("inside did set \(user)")
            
        }
        
    }
    
    var conversation: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        messageField.delegate = self
        messageField.inputAccessoryView = formHolder
        
        formHolder.backgroundColor = UIColor.whiteColor()
        formHolder.addSubview(messageField)
        formHolder.addSubview(sendButton)
        
        messageField.inputAccessoryView = formHolder
        
        self.view.addSubview(formHolder)
        
        var nc = NSNotificationCenter.defaultCenter()
        nc.addObserverForName("newMessage", object: nil, queue: NSOperationQueue.mainQueue(), usingBlock: { (notification: NSNotification!) -> Void in
            
            // update conversation and reload tableView
            
            var messageQuery = PFQuery(className: "Message")
            
            messageQuery.whereKey("receiver", equalTo: PFUser.currentUser())
            messageQuery.whereKey("sender", equalTo: self.friend)
            messageQuery.limit = 1
            messageQuery.orderByDescending("createdAt")
            
//            messageQuery.whereKey("content", equalTo:)
            
            messageQuery.findObjectsInBackgroundWithBlock { (messages: [AnyObject]!, error: NSError!) -> Void in
                
                if messages.count > 0 {
                    self.conversation += messages as [PFObject]
                    self.tableView.reloadData()
                    
                    let indexPath = NSIndexPath(forRow: self.conversation.count - 1, inSection: 0)
                    
                    self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: false)
                }
                
            }
            
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return conversation.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("messageCell", forIndexPath: indexPath) as MessageCell
        
        cell.messageInfo = conversation[indexPath.row]
        
//        cell.textLabel?.text = conversation[indexPath.row]["content"] as? String
        
        return cell
        
    }
    
    var defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
//        conversation = defaults.arrayForKey(friend.username) as [PFObject]!
        
        var messageQuery = PFQuery(className: "Message")
        
        var possibleRelations = [PFUser.currentUser().username + friend.username, friend.username + PFUser.currentUser().username]
        
        messageQuery.whereKey("relation", containedIn: possibleRelations)
        messageQuery.orderByAscending("createdAt")
        
        messageQuery.findObjectsInBackgroundWithBlock { (messages: [AnyObject]!, error: NSError!) -> Void in
            
            if messages.count > 0 {
                self.conversation = messages as [PFObject]
                self.tableView.reloadData()
                
                let indexPath = NSIndexPath(forRow: self.conversation.count - 1, inSection: 0)
            
                self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: false)
            }
            
        }
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        println(messageField.inputView)

//        (messageField.inputAccessoryView?.subviews[0] as UITextField).becomeFirstResponder()
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.sendMessage(textField)
        return true
        
    }
    
    @IBAction func sendMessage(sender: AnyObject) {
        
        messageField.resignFirstResponder()
        
        formHolder.frame.origin.y = SCREEN_HEIGHT - formHolder.frame.size.height
        
        var message = PFObject(className: "Message")
        message["sender"] = PFUser.currentUser()
        message["receiver"] = friend
        message["content"] = messageField.text
        message["relation"] = PFUser.currentUser().username + friend.username
        message["read"] = false
        
        conversation.append(message)
        
        message.saveInBackground()
        tableView.reloadData()
        
        let indexPath = NSIndexPath(forRow: self.conversation.count - 1, inSection: 0)

        self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: false)
        
        var deviceQuery = PFInstallation.query()
        deviceQuery.whereKey("user", equalTo: friend)
        
        var data = NSDictionary(objects: [self.messageField.text,self.friend,"Increment"], forKeys: ["alert","sender","badge"])
        
        var push = PFPush()
        push.setQuery(deviceQuery)
        push.setData(data)
        push.sendPushInBackground()
    
        messageField.text = ""
    }


}

