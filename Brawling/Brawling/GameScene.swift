//
//  GameScene.swift
//  Brawling
//
//  Created by Jo Albright on 2/11/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import SpriteKit
import MultipeerConnectivity

enum NodeType: UInt32 {
    case Player = 1
    case Projectile = 2
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var playerNodes: [PlayerNode] = []
    var projectileNodes: [ProjectileNode] = []
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.physicsWorld.contactDelegate = self
        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: view.frame)
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        if contact.bodyA.categoryBitMask == NodeType.Projectile.rawValue && contact.bodyB.categoryBitMask == NodeType.Player.rawValue {
            
            // body A = Projectile
            
            // body B = Player
            
            let projectile = contact.bodyA.node as ProjectileNode
            let pNode = contact.bodyB.node as PlayerNode
            
            let healthPoints = pNode.player?.attackWithDamage(projectile.damage)
            if healthPoints <= 0 {

                projectile.player?.killCount++
                pNode.player?.deathCount++
                pNode.removeFromParent()
                playerReady(pNode.player!)
            
            }
            
            projectile.removeFromParent()
            
        } else if contact.bodyB.categoryBitMask == NodeType.Projectile.rawValue && contact.bodyA.categoryBitMask == NodeType.Player.rawValue {
            
            // body B = Projectile
            
            // body A = Player
            
            let projectile = contact.bodyB.node as ProjectileNode
            let pNode = contact.bodyA.node as PlayerNode
            
            let healthPoints = pNode.player?.attackWithDamage(projectile.damage)
            if healthPoints <= 0 {
                
                projectile.player?.killCount++
                pNode.player?.deathCount++
                pNode.removeFromParent()
                playerReady(pNode.player!)
                
            }
            
            projectile.removeFromParent()
            
        } else if contact.bodyB.categoryBitMask == NodeType.Projectile.rawValue {
            
            // body B = Projectile
            
            // body A = maybe the wall
            
            let projectile = contact.bodyB.node as ProjectileNode
            
            projectile.removeFromParent()
            
        } else if contact.bodyA.categoryBitMask == NodeType.Projectile.rawValue {
            
            // body A = Projectile
            
            // body B = maybe the wall
            
            let projectile = contact.bodyA.node as ProjectileNode
            
            projectile.removeFromParent()
            
        }
        
        
        println("A = \(contact.bodyA.categoryBitMask)")
        println("B = \(contact.bodyB.categoryBitMask)")
        
    }
    
    func movePlayer(player: Player, inDirection direction: String) {
        
        if let pNode = findNodeForPlayer(player) {
            
            switch direction {
                
            case "left" :
                
                pNode.physicsBody?.applyForce(CGVectorMake(-1000, 0))
                
            case "right" :
                
                pNode.physicsBody?.applyForce(CGVectorMake(1000, 0))
                
            case "up" :
                
                pNode.physicsBody?.applyForce(CGVectorMake(0, 6000))
                
            default :
                
                println("I can't move in that direction")
                
            }
            
        }
        
        
    }
    
    func actionFire(fire: String, fromPlayer player: Player) {
        
        if let pNode = findNodeForPlayer(player) {

            // some code
            
            switch fire {
                
            case "normal" :
                
//                pNode.physicsBody?.applyForce(CGVectorMake(-1000, 0))
                
                var projectile = ProjectileNode(color: UIColor.blueColor(), size: CGSizeMake(10, 10))
                
                projectile.player = player
                projectile.damage = 10
                projectile.physicsBody = SKPhysicsBody(rectangleOfSize: projectile.size)
                projectile.physicsBody?.affectedByGravity = false
                
                projectile.position = pNode.position
                projectile.position.x += 30
                
                projectile.physicsBody?.categoryBitMask = NodeType.Projectile.rawValue
                
                projectile.physicsBody?.contactTestBitMask = NodeType.Player.rawValue
                
                projectileNodes.append(projectile)
                
                self.addChild(projectile)
                
                projectile.physicsBody?.applyImpulse(CGVectorMake(10, 0))
                
            case "special" :
                
//                pNode.physicsBody?.applyForce(CGVectorMake(1000, 0))
               
                var projectile = ProjectileNode(color: UIColor.greenColor(), size: CGSizeMake(20, 20))
                
                projectile.player = player
                projectile.damage = 35
                projectile.physicsBody = SKPhysicsBody(rectangleOfSize: projectile.size)
                projectile.physicsBody?.affectedByGravity = false
                
                projectile.position = pNode.position
                projectile.position.x += 40
                
                projectile.physicsBody?.categoryBitMask = NodeType.Projectile.rawValue
                
                projectile.physicsBody?.contactTestBitMask = NodeType.Player.rawValue
                
                projectileNodes.append(projectile)
                
                self.addChild(projectile)
                
                projectile.physicsBody?.applyImpulse(CGVectorMake(100, 0))
                
            default :
                
                println("I don't have ammo for that")
                
            }
            
            // some code
            
        }
        
    }
    
    func playerIncoming(player: Player) {
        
        // show player health bar at top
        
    }
    
    func playerReady(player: Player) {
        
        // add player node to scene
        
        var pNode = PlayerNode(color: UIColor.redColor(), size: CGSizeMake(30, 30))
        
        player.healthPoints = 100
        
        pNode.player = player
        pNode.position = CGPointMake(200, 200)
        pNode.physicsBody = SKPhysicsBody(rectangleOfSize: pNode.size)
        
        pNode.physicsBody?.categoryBitMask = NodeType.Player.rawValue
        
        playerNodes.append(pNode)
        
        self.addChild(pNode)
        
    }
    
    func playerLeft(player: Player) {
        
        // remove player from scene and remove health bar
        
        if let node = findNodeForPlayer(player) {
            
            if let i = find(playerNodes, node) {
                playerNodes.removeAtIndex(i)
            }
            node.removeFromParent()
            
        }
        
    }
    
    func findNodeForPlayer(player: Player) -> PlayerNode? {
        
        for node in playerNodes {
            
            if node.player!.displayName == player.displayName {
                
                return node
                
            }
            
        }
        
        return nil
        
    }
    
}
