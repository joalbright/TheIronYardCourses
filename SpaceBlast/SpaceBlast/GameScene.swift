//
//  GameScene.swift
//  SpaceBlast
//
//  Created by Jo Albright on 2/9/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var screenCenter: CGPoint!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        screenCenter = view.center
        
        createMoon()
        
        let ship = SKSpriteNode(imageNamed: "ship")
        
        ship.position = screenCenter
        
        self.addChild(ship)
        
        // add gestures up and down to move ship
        
        // make sound "pfft"
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            // shoot ship beams
            
            // make sound "pew, pew"
            
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    
    func createMoon() {
        
        let moon = SKShapeNode(ellipseOfSize: CGSizeMake(500, 500))
        
        moon.strokeColor = SKColor.clearColor()
        moon.fillColor = SKColor(white: 0.9, alpha: 1.0)
        moon.position = CGPointMake(screenCenter.x, -300)
        
        moon.xScale = 2.5
        moon.yScale = 2.5
        
        self.addChild(moon)
        
        let craters: [(CGPoint,CGFloat)] = [
            
            (CGPointMake(40, 50),50),
            (CGPointMake(180, 100),30),
            (CGPointMake(100, -50),20),
            (CGPointMake(120, -80),10),
            (CGPointMake(-40, -150),10),
            (CGPointMake(-140, -100),45),
            (CGPointMake(-180, -50),38),
            (CGPointMake(-10, -50),20)
            
        ]
        
        for (p,s) in craters {
            
            let crater = SKShapeNode(ellipseOfSize: CGSizeMake(s, s))
            crater.fillColor = SKColor(white: 0.8, alpha: 1.0)
            crater.position = p
            
            moon.addChild(crater)
            
        }
        
        let moonRotation = SKAction.rotateByAngle(CGFloat(M_PI), duration: 10)
        
        moon.runAction(SKAction.repeatActionForever(moonRotation))
        
    }
    
}
