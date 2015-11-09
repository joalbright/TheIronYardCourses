//
//  GameScene.swift
//  ExploreSpriteImages
//
//  Created by Jo Albright on 10/29/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        scene?.backgroundColor = UIColor.blackColor()
        
        view.showsPhysics = true
        
        size = view.frame.size
        physicsBody = SKPhysicsBody(edgeLoopFromRect: view.frame)
        
        
        let monkeyAtlas = SKTextureAtlas(named: "monkey.atlas")
        
        let monkey = SKSpriteNode(texture: monkeyAtlas.textureNamed("monkey1"))
        
        monkey.position = view.center
        
        addChild(monkey)
        
        let monkeyTextures = monkeyAtlas.textureNames.map {
            
            SKTexture(imageNamed: $0)
            
        }
        
        let action = SKAction.animateWithTextures(monkeyTextures, timePerFrame: 0.2)
        
        monkey.runAction(SKAction.repeatActionForever(action))
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            
            let location = touch.locationInNode(self)
            
            let balloon = SKSpriteNode(imageNamed: "Balloon")
            
            balloon.position = location
            
            balloon.physicsBody = SKPhysicsBody(texture: balloon.texture!, size: balloon.frame.size)
            
            balloon.physicsBody?.restitution = 0.8
            balloon.physicsBody?.linearDamping = 0.8
            
            addChild(balloon)
            
        }
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
}



