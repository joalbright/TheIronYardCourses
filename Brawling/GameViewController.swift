//
//  GameViewController.swift
//  Brawling
//
//  Created by Jo Albright on 2/11/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit
import SpriteKit
import MultipeerConnectivity

extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController, MCSessionDelegate, MCNearbyServiceBrowserDelegate {

    var browser: MCNearbyServiceBrowser!
    var session: MCSession!
    var myPeerID: MCPeerID!
    
    let serviceType = "Brawling10"
    
    var scene: GameScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myPeerID = MCPeerID(displayName: "BrawlingRoom")
        session = MCSession(peer: myPeerID)
        session.delegate = self
        
        browser = MCNearbyServiceBrowser(peer: myPeerID, serviceType: serviceType)
        browser.delegate = self
        
        browser.startBrowsingForPeers()
        
        scene = GameScene.unarchiveFromFile("GameScene") as? GameScene
        
        if let scene = scene {
            // Configure the view.
            let skView = self.view as SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
    }
    
    //////////////////////////
    ////////////////////////// BROWSER
    //////////////////////////

    func browser(browser: MCNearbyServiceBrowser!, foundPeer peerID: MCPeerID!, withDiscoveryInfo info: [NSObject : AnyObject]!) {
        
        // find peer
        
        browser.invitePeer(peerID, toSession: session, withContext: nil, timeout: 30)
        
        var newPlayer = Player()
        
        newPlayer.displayName = peerID.displayName
        
        Game.mainGame().players.append(newPlayer)
        
    }
    
    func browser(browser: MCNearbyServiceBrowser!, lostPeer peerID: MCPeerID!) {
        
        
        for (p,player) in enumerate(Game.mainGame().players) {
            
            if player.displayName == peerID.displayName {
                
                //// this line might crash app, since i am removing while in a loop
                if p < Game.mainGame().players.count { Game.mainGame().players.removeAtIndex(p) }
                
            }
            
        }
        
        println("lost peer")
        
        // lost peer
        
    }
    
    //////////////////////////
    ////////////////////////// SESSION
    //////////////////////////
    
    func session(session: MCSession!, didFinishReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, atURL localURL: NSURL!, withError error: NSError!) {
        
    }
    
    func session(session: MCSession!, didReceiveData data: NSData!, fromPeer peerID: MCPeerID!) {
        
        // possible move or fire actions
        
        if let player = Game.mainGame().findPlayerWithDisplayName(peerID.displayName) {
        
            if let info = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? [String: AnyObject] {
                
                if let direction = info["direction"] as? String {
                    
                    scene?.movePlayer(player, inDirection: direction)
                    
                }
                
                if let fire = info["fire"] as? String {
                    
                    scene?.actionFire(fire, fromPlayer: player)
                    
                }
                
            }
            
        }
        
    }
    
    func session(session: MCSession!, didReceiveStream stream: NSInputStream!, withName streamName: String!, fromPeer peerID: MCPeerID!) {
        
    }
    
    func session(session: MCSession!, didStartReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, withProgress progress: NSProgress!) {
        
    }
    
    func session(session: MCSession!, peer peerID: MCPeerID!, didChangeState state: MCSessionState) {
        
        if let player = Game.mainGame().findPlayerWithDisplayName(peerID.displayName) {
            
            println(player.displayName)
        
            switch state {
                
            case .Connected :
                
                println("Connected")
                // add player to game
                
                scene?.playerReady(player)
                
            case .Connecting :
                
                println("Connecting")
                // show new player incoming
                
                scene?.playerIncoming(player)
                
            case .NotConnected :
                
                println("NotConnected")
                // remove player from screen
                
                scene?.playerLeft(player)
                
            }
            
        }
        
    }
    
    //////////////////////////
    //////////////////////////
    //////////////////////////
    
    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
