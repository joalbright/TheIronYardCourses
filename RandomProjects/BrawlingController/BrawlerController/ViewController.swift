//
//  ViewController.swift
//  BrawlerController
//
//  Created by Jo Albright on 2/11/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit
import MultipeerConnectivity


class ViewController: UIViewController, MCSessionDelegate, MCNearbyServiceAdvertiserDelegate  {
    
    var session: MCSession!
    var myPeerID: MCPeerID!
    var advertiser: MCNearbyServiceAdvertiser!
    
    let serviceType = "Brawling10"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myPeerID = MCPeerID(displayName: "RedLeader")
        
        session = MCSession(peer: myPeerID)
        session.delegate = self
        
        advertiser = MCNearbyServiceAdvertiser(peer: myPeerID, discoveryInfo: nil, serviceType: serviceType)
        advertiser.delegate = self
        
        advertiser.startAdvertisingPeer()
        
    }

    @IBAction func pressUp(sender: AnyObject) {
        
        sendDataWithInfo(["direction":"up"])
        
    }
    
    @IBAction func pressRight(sender: AnyObject) {
        
        sendDataWithInfo(["direction":"right"])
        
    }
    
    @IBAction func pressLeft(sender: AnyObject) {
        
        sendDataWithInfo(["direction":"left"])
        
    }
    
    @IBAction func pressFire1(sender: AnyObject) {
    
        sendDataWithInfo(["fire":"normal"])

    }
    
    @IBAction func pressFire2(sender: AnyObject) {

        sendDataWithInfo(["fire":"special"])
    
    }
    
    func sendDataWithInfo(info: [String:String]) {
        
        let moveData = NSJSONSerialization.dataWithJSONObject(info, options: NSJSONWritingOptions.allZeros, error: nil)
        
        if let roomPeerID = roomPeerID {
            
            var error: NSError?
            
            session.sendData(moveData, toPeers: [roomPeerID], withMode: MCSessionSendDataMode.Reliable, error: &error)
            
            println(error)
        }
        
    }
    
    var roomPeerID: MCPeerID?
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser!, didReceiveInvitationFromPeer peerID: MCPeerID!, withContext context: NSData!, invitationHandler: ((Bool, MCSession!) -> Void)!) {
        
        roomPeerID = peerID
        
        println("invite from \(peerID)")
        
        invitationHandler(true,session)
        
    }
    
    func session(session: MCSession!, didFinishReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, atURL localURL: NSURL!, withError error: NSError!) {
        
    }
    
    func session(session: MCSession!, didReceiveData data: NSData!, fromPeer peerID: MCPeerID!) {
        
    }
    
    func session(session: MCSession!, didReceiveStream stream: NSInputStream!, withName streamName: String!, fromPeer peerID: MCPeerID!) {
        
    }
    
    func session(session: MCSession!, didStartReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, withProgress progress: NSProgress!) {
        
    }
    
    func session(session: MCSession!, peer peerID: MCPeerID!, didChangeState state: MCSessionState) {
        
        println("\(state.rawValue) = \(peerID)")
        
        println(session.connectedPeers)
        
    }


}

