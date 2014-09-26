//
//  ViewController.swift
//  MPC
//
//  Created by Jo Albright on 9/19/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController, MCBrowserViewControllerDelegate,
MCSessionDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var chatTableView: UITableView!
    
    var messages: [[String:String]] = []
    
    let serviceType = "yellChat"
    
    var browser : MCBrowserViewController!
    var assistant : MCAdvertiserAssistant!
    var session : MCSession!
    var peerID: MCPeerID!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameField.delegate = self
        messageField.delegate = self
        
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
        self.peerID = MCPeerID(displayName: UIDevice.currentDevice().name)
        self.session = MCSession(peer: peerID)
        self.session.delegate = self
        
        // create the browser viewcontroller with a unique service name
        self.browser = MCBrowserViewController(serviceType:serviceType,
            session:self.session)
        
        self.browser.delegate = self;
        
        self.assistant = MCAdvertiserAssistant(serviceType:serviceType,
            discoveryInfo:nil, session:self.session)
        
        // tell the assistant to start advertising our fabulous chat
        self.assistant.start()
    }
    
    @IBAction func sendChat(sender: UIButton) {
        // Bundle up the text in the message field, and send it off to all
        // connected peers
        
        let msg = self.messageField.text.dataUsingEncoding(NSUTF8StringEncoding,
            allowLossyConversion: false)
        
        var error : NSError?
        
        self.session.sendData(msg, toPeers: self.session.connectedPeers,
            withMode: MCSessionSendDataMode.Unreliable, error: &error)
        
        if error != nil {
            print("Error sending data: \(error?.localizedDescription)")
        }
        
        messages.append([
            "name":usernameField.text,
            "text":messageField.text
            ])
        
        chatTableView.reloadData()
        
//        self.updateChat(self.messageField.text, fromPeer: self.peerID)
        
        self.messageField.text = ""
    }
    
//    func updateChat(text : String, fromPeer peerID: MCPeerID) {
//        // Appends some text to the chat view
//        
//        // If this peer ID is the local device's peer ID, then show the name
//        // as "Me"
//        var name : String
//        
//        switch peerID {
//        case self.peerID:
//            name = "Me"
//        default:
//            name = peerID.displayName
//        }
//        
//        // Add the name to the message and display it
//        let message = "\(name): \(text)\n"
////        self.chatView.text = self.chatView.text + message
//        
//    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField == usernameField {
            
            self.peerID = MCPeerID(displayName: usernameField.text)
            self.presentViewController(self.browser, animated: true, completion: nil)
            
        }
        
        textField.resignFirstResponder()
        
        return true
    }
    
//    @IBAction func showBrowser(sender: UIButton) {
//        // Show the browser view controller
//        self.presentViewController(self.browser, animated: true, completion: nil)
//    }
    
    func browserViewControllerDidFinish(
        browserViewController: MCBrowserViewController!)  {
            // Called when the browser view controller is dismissed (ie the Done
            // button was tapped)
            
            self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(
        browserViewController: MCBrowserViewController!)  {
            // Called when the browser view controller is cancelled
            
            self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func session(session: MCSession!, didReceiveData data: NSData!,
        fromPeer peerID: MCPeerID!)  {
            // Called when a peer sends an NSData to us
            
            // This needs to run on the main queue
            dispatch_async(dispatch_get_main_queue()) {
                
                var msg = NSString(data: data, encoding: NSUTF8StringEncoding)
                
//                self.updateChat(msg, fromPeer: peerID)
                
                self.messages.append([
                    "name":peerID.displayName,
                    "text":msg
                    ])
                
                self.chatTableView.reloadData()
                
            }
    }
    
    // The following methods do nothing, but the MCSessionDelegate protocol
    // requires that we implement them.
    func session(session: MCSession!,
        didStartReceivingResourceWithName resourceName: String!,
        fromPeer peerID: MCPeerID!, withProgress progress: NSProgress!)  {
            
            // Called when a peer starts sending a file to us
    }
    
    func session(session: MCSession!,
        didFinishReceivingResourceWithName resourceName: String!,
        fromPeer peerID: MCPeerID!,
        atURL localURL: NSURL!, withError error: NSError!)  {
            // Called when a file has finished transferring from another peer
    }
    
    func session(session: MCSession!, didReceiveStream stream: NSInputStream!,
        withName streamName: String!, fromPeer peerID: MCPeerID!)  {
            // Called when a peer establishes a stream with us
    }
    
    func session(session: MCSession!, peer peerID: MCPeerID!,
        didChangeState state: MCSessionState)  {
            // Called when a connected peer changes state (for example, goes offline)
            
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("yellCell", forIndexPath: indexPath) as UITableViewCell
        
        var message = messages[indexPath.row]
        
        cell.textLabel?.text = message["text"]
        cell.detailTextLabel?.text = message["name"]
        
        return cell
    }
}

