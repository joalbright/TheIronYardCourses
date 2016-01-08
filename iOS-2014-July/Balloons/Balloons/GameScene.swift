//
//  GameScene.swift
//  Balloons
//
//  Created by Jo Albright on 8/21/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var centerPoint = CGPointMake(0,0)
    
    var balloons:[SKSpriteNode] = []
    
    var darts:[SKSpriteNode] = []
    
    override func didMoveToView(view: SKView) {
        
        centerPoint = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame))
        
//        self.physicsWorld.gravity = CGVectorMake(0, -9.0)
        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsWorld.contactDelegate = self
        
        
        self.createBalloons()
        
    }
    
    func createBalloons() {
        
        for i in 0...4 {
            
            var spriteNode = SKSpriteNode(imageNamed: "balloon_gold")
            
            spriteNode.xScale = 0.5
            spriteNode.yScale = 0.5
            
            spriteNode.physicsBody = SKPhysicsBody(circleOfRadius: spriteNode.frame.size.width / 2.0)
            
            spriteNode.physicsBody.restitution = 0.8
            spriteNode.physicsBody.mass = 0.2
            
            spriteNode.physicsBody.categoryBitMask = 1
            
            var floatI = CGFloat(i)
            
            spriteNode.position = CGPointMake(self.frame.width / 4.0 * floatI, 300.0)
            
            self.addChild(spriteNode)
            
            balloons += [spriteNode]
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            
            let location = touch.locationInNode(self)
            
            var dart = SKSpriteNode(imageNamed: "Dart")
            
            dart.position = location
            
            dart.physicsBody = SKPhysicsBody(rectangleOfSize: dart.size)
            
//            dart.physicsBody = SKPhysicsBody(texture: dart.texture, alphaThreshold: 0.99, size: dart.size)
            
            dart.physicsBody.contactTestBitMask = 1
            
            dart.physicsBody.allowsRotation = false
            
            self.addChild(dart)
            
            darts += [dart]
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact!) {
        
        println("contact")
        
        var poppedBalloon: SKSpriteNode?
        
        for balloon in balloons
        {
            if contact.bodyA.node != nil && contact.bodyB.node != nil
            {
                if balloon == contact.bodyA.node || balloon == contact.bodyB.node
                {
                    poppedBalloon = balloon
                }
            }
        }
        
        if poppedBalloon != nil
        {
            poppedBalloon!.removeFromParent()
            
            
            
            var pop = SKAction.playSoundFileNamed("pop.mp3", waitForCompletion: false)
            
            self.runAction(pop)
        }
        
        println(balloons.count)
        
        if balloons.count == 0 {
            
            for dart in darts
            {
                dart.removeFromParent()
            }
            
            darts.removeAll(keepCapacity: false)
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC)), dispatch_get_main_queue(), { () -> Void in

                self.createBalloons()

            })
            
        }
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
