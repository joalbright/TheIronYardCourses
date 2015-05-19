//
//  ViewController.swift
//  Smash
//
//  Created by Jo Albright on 5/19/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var animator: UIDynamicAnimator!
    var gravityBehavior = UIGravityBehavior()
    var collisionBehavior = UICollisionBehavior()
    var ballBehavior = UIDynamicItemBehavior()
    
    var ball = UIView(frame: CGRectMake(20, 20, 20, 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ball.backgroundColor = UIColor.blackColor()
        ball.layer.cornerRadius = 10
        view.addSubview(ball)
        
        ///////////
        
        animator = UIDynamicAnimator(referenceView: view)
        
        animator.addBehavior(gravityBehavior)
        animator.addBehavior(collisionBehavior)
        animator.addBehavior(ballBehavior)
        
        gravityBehavior.addItem(ball)
        
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.addItem(ball)
        
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        var ball = UIView(frame: CGRectMake(0, 0, 20, 20))
        ball.layer.cornerRadius = 10
        ball.backgroundColor = UIColor.blackColor()
        
        view.addSubview(ball)
        
        if let touch = touches.first as? UITouch {
            
            let location = touch.locationInView(view)
            ball.center = location
            
        }
        
        gravityBehavior.addItem(ball)
        collisionBehavior.addItem(ball)
        
    }
    
}



