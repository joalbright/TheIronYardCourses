//
//  Character.swift
//  SAMK
//
//  Created by Jo Albright on 9/22/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

import UIKit
import SpriteKit

let FIRE_CONTACT: UInt32 = 10
let PLAYER_CONTACT: UInt32 = 12
let MAX_HP: Int = 100

class Character: NSObject {
   
    var body: SKSpriteNode!
    var direction: CGFloat = 1.0 // right
    
    var currentHP: Int = 100
    
    var textureNames: [String] = []
    
    init(animal:String) {
//        super.init()
        
        var characterAtlas = SKTextureAtlas(named: animal)
        
        textureNames = sorted(characterAtlas.textureNames as [String],<)
        
        body = SKSpriteNode(imageNamed: textureNames[0] as String)
        body.size = CGSizeMake(40, 80)
        
//        body.fillColor = UIColor.whiteColor()
        body.physicsBody = SKPhysicsBody(rectangleOfSize: body.frame.size)
        body.physicsBody?.allowsRotation = false
//        body.physicsBody?.categoryBitMask = PLAYER_CONTACT

    }
    
    func checkHit(bodyA:SKPhysicsBody, bodyB: SKPhysicsBody) {
        
        if bodyA.node == body {
            
            currentHP -= 10
            bodyB.node?.removeFromParent()
            
            NSNotificationCenter.defaultCenter().postNotificationName("healthUpdate", object: nil, userInfo: ["player":self])
            
        }
        
        
        
//        if bodyB.node == body {
//            
//            currentHP -= 10
//            bodyA.node?.removeFromParent()
//            
//        }
        
    }
    
    func moveLeft() {
        direction = -1
        body.physicsBody?.applyImpulse(CGVectorMake(-30.0, 0.0))
        
        var walkAction = SKAction.animateWithTextures(texturesFromNames(), timePerFrame: 0.1, resize: false, restore: true)
        
        body.runAction(walkAction)
        
        body.xScale = direction
    }
    
    func moveRight() {
        direction = 1
        body.physicsBody?.applyImpulse(CGVectorMake(30.0, 0.0))
        
        var walkAction = SKAction.animateWithTextures(texturesFromNames(), timePerFrame: 0.1, resize: false, restore: true)
        
        body.runAction(walkAction)
        
        body.xScale = direction
    }
    
    func jump() {
        body.physicsBody?.applyImpulse(CGVectorMake(0.0, 100.0))
    }
    
    func fire() {
        //var kamehameha = SKShapeNode(rectOfSize: CGSizeMake(100, 100), cornerRadius: 50)
        
        var particlePath = NSBundle.mainBundle().pathForResource("MyParticle", ofType: "sks")
        
        //        var kamehameha = NSKeyedUnarchiver.unarchiveObjectWithFile(particlePath!) as SKEmitterNode
        
        ////////// REMOVE
        
        var sceneData = NSData.dataWithContentsOfFile(particlePath!, options: .DataReadingMappedIfSafe, error: nil)
        var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
        
        archiver.setClass(SKEmitterNode.self, forClassName: "SKEditorScene")
        let node = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as SKEmitterNode?
        archiver.finishDecoding()
        
        var kamehameha = node!
        
        ////////// REMOVE
        
        //        kamehameha.fillColor = UIColor.cyanColor()
        kamehameha.position = CGPointMake(body.position.x + 50 * direction, body.position.y)
        
        kamehameha.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        kamehameha.physicsBody?.affectedByGravity = false
        
//        scene.addChild(kamehameha)
    
        body.parent?.addChild(kamehameha)
        
        kamehameha.physicsBody?.applyImpulse(CGVectorMake(10.0 * direction, 0.0))
        
        body.physicsBody?.applyImpulse(CGVectorMake(-5.0 * direction, 0.0))
        
        kamehameha.physicsBody?.contactTestBitMask = FIRE_CONTACT
//        kamehameha.physicsBody?.collisionBitMask = FIRE_CONTACT
    }
    
    func texturesFromNames() -> [SKTexture] {
        
        var textures: [SKTexture] = []
        
        for textureName in textureNames {
            
            textures.append(SKTexture(imageNamed: textureName))
            
        }
        
        return textures
    }
}
