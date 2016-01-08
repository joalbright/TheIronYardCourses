//
//  GameViewController.swift
//  StuffedAnimalMortalKombat
//
//  Created by Jo Albright on 6/9/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit
import SpriteKit
import MultipeerConnectivity

extension SKNode {
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {
    
    var scene: GameScene?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Connector.sharedConnector().gameBoard = self
        Connector.sharedConnector().startBrowsing()

        scene = GameScene.unarchiveFromFile("GameScene") as? GameScene

        if let scene = scene {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
    }
    
    var playerViews: [PlayerStats] = []
    
    func playerJoined(peerID: MCPeerID) {
        
        println("player joined " + peerID.displayName)
        
        if let playerVC = storyboard?.instantiateViewControllerWithIdentifier("playerStats") as? UIViewController {
            
            let playerView = playerVC.view as! PlayerStats
            
            playerView.statsLives.lifeCount = 3
            playerView.playerName.text = peerID.displayName
            
            playerViews.append(playerView)
            
            scene?.playerJoined(peerID.displayName)
            
        }
        
        layoutPlayerStats()
        
    }
    
    func playerLeft(peerID: MCPeerID) {
        
        var foundPlayerViewIndex: Int?
        
        for (p,playerView) in enumerate(playerViews) {
            
            if let name = playerView.playerName.text, peerName = peerID.displayName where name == peerName {
                
                foundPlayerViewIndex = p
                scene?.playerLeft(name)
                
            }
            
        }
        
        // remove all playerViews
        for playerView in playerViews { playerView.removeFromSuperview() }
        
        if let foundPlayerViewIndex = foundPlayerViewIndex {
            
            playerViews.removeAtIndex(foundPlayerViewIndex)
            
        }
        
        
        layoutPlayerStats()
        
    }

    func layoutPlayerStats() {
        
        let padding: CGFloat = 20
        let maxPlayers: CGFloat = 6
        
        let playerStatsWidth = (view.frame.width - (padding * (maxPlayers + 1))) / maxPlayers
        
        for (p,playerView) in enumerate(playerViews) {
            
            view.addSubview(playerView)
            
            let x = (playerStatsWidth + padding) * CGFloat(p) + padding
            
            playerView.frame = CGRectMake(x, padding, playerStatsWidth, 300)
            
            println(playerView)
            println(playerView.healthBar.points)
            println(playerView.statsLives.lifeCount)
            
            view.layoutSubviews()
            
        }
        
    }
    
    
    // player movement functions
    
    // player attack functions

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
