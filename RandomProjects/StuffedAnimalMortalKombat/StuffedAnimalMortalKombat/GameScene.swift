//
//  GameScene.swift
//  StuffedAnimalMortalKombat
//
//  Created by Jo Albright on 6/9/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let playerCount: CGFloat = 8
    let statsPadding: CGFloat = 20
    
    var playerStatsWidth: CGFloat!
    
    override func didMoveToView(view: SKView) {
                
        playerStatsWidth = (view.bounds.width - (statsPadding * (playerCount + 1))) / playerCount
        
        Connector.sharedConnector().gameScene = self
        
    }
    
    func playerJoined(name: String) {
        
        var playerNode = PlayerNode(color: UIColor.blackColor(), size: CGSizeMake(40, 40))
        
        playerNode.name = name
        playerNode.position = CGPointMake(500, 500)
        playerNode.physicsBody = SKPhysicsBody(rectangleOfSize: playerNode.size)
        
        if let info = Connector.sharedConnector().playersInfo[name] as? [String: AnyObject] {
            
            if let color = info["color"] as? UIColor {
                
                playerNode.color = color
                
            }
            
        }
        
        addChild(playerNode)
        
    }
    
    func playerLeft(name: String) {
        println(childNodeWithName(name))
        
        if let playerNode = childNodeWithName(name) {
            
            playerNode.removeFromParent()
            
        }
        
    }
    
    func playerJump(name: String) {
        
        if let playerNode = childNodeWithName(name) {
            
            playerNode.physicsBody?.applyImpulse(CGVectorMake(0.0, 20.0))
            
        }
        
    }
    
    func playerMove(name: String, withDirection direction: Int) {
        
    }
    
    func playerStop(name: String) {
        
        
    }
    
    var sunRotation: Double = 0
   
    override func update(currentTime: CFTimeInterval) {
        
    }
    
}

class PlayerNode: SKSpriteNode {
    
//    var name: String!
    
}
