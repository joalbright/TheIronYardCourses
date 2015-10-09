//
//  GameViewController.swift
//  Break
//
//  Created by Jo Albright on 10/8/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import UIKit

enum BoundaryType: String {
    
    case Floor,LeftWall,RightWall,Ceiling
    
}

class GameViewController: UIViewController, UIDynamicAnimatorDelegate, UICollisionBehaviorDelegate {
    
    var animator: UIDynamicAnimator!
    
    let ballBehavior = UIDynamicItemBehavior()
    let brickBehavior = UIDynamicItemBehavior()
    let paddleBehavior = UIDynamicItemBehavior()
    
    var attachment: UIAttachmentBehavior?
    
    let gravity = UIGravityBehavior()
    let collision = UICollisionBehavior()

    let topBar = TopBarView(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
    let paddle = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 10))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: view)
        
        animator.delegate = self
        
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        animator.addBehavior(ballBehavior)
        animator.addBehavior(brickBehavior)
        animator.addBehavior(paddleBehavior)
        
        collision.collisionDelegate = self
        
        // setup ball behavior
        
        ballBehavior.friction = 0
        ballBehavior.resistance = 0
        ballBehavior.elasticity = 1
        ballBehavior.allowsRotation = false
        
        // setup brick behavior
        
        brickBehavior.anchored = true
        
        // setup paddle behavior
        
        paddleBehavior.allowsRotation = false
//        paddleBehavior.anchored = true
        
        // background
        
        let bg = UIImageView(image: UIImage(named: "background"))
        bg.frame = view.frame
        view.addSubview(bg)
        
        // topbar
        
        topBar.frame.size.width = view.frame.width
        view.addSubview(topBar)
        
        
        let ball = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        ball.layer.cornerRadius = 10
        ball.backgroundColor = UIColor.whiteColor()
        view.addSubview(ball)
        
        ball.center = view.center
        
        ballBehavior.addItem(ball)
        collision.addItem(ball)
        
        
        // wrap view in boundary
        collision.translatesReferenceBoundsIntoBoundary = true
        
        collision.addBoundaryWithIdentifier(BoundaryType.Ceiling.rawValue, fromPoint: CGPoint(x: 0, y: 50), toPoint: CGPoint(x: view.frame.width, y: 50))
        
        collision.addBoundaryWithIdentifier(BoundaryType.Floor.rawValue, fromPoint: CGPoint(x: 0, y: view.frame.height - 10), toPoint: CGPoint(x: view.frame.width, y: view.frame.height - 10))
        
        // push
        
        let push = UIPushBehavior(items: [ball], mode: UIPushBehaviorMode.Instantaneous)
        
        push.pushDirection = CGVector(dx: 0.2, dy: -0.2)
        
        animator.addBehavior(push)
        
        // paddle
        
        paddle.backgroundColor = UIColor.blackColor()
        paddle.layer.cornerRadius = 5
        
        paddle.center = CGPoint(x: view.center.x, y: view.frame.height - 40)
        
        view.addSubview(paddle)
        
        paddleBehavior.addItem(paddle)
        collision.addItem(paddle)
        
        attachment = UIAttachmentBehavior(item: paddle, attachedToAnchor: paddle.center)
        
        animator.addBehavior(attachment!)
        
        // bricks 
        
        let cols = 8
        let rows = 3
        
        let brickH = 30
        let brickSpacing = 5
        
        let totalSpacing = (cols + 1) * brickSpacing
        let brickW = (Int(view.frame.width) - totalSpacing) / cols
        
        for c in 0..<cols {
            
            for r in 0..<rows {
                
                let x = c * (brickW + brickSpacing) + brickSpacing
                let y = r * (brickH + brickSpacing) + brickSpacing + 60
                
                let brick = UIView(frame: CGRect(x: x, y: y, width: brickW, height: brickH))
                brick.backgroundColor = UIColor.blackColor()
                brick.layer.cornerRadius = 5
                
                view.addSubview(brick)
                
                collision.addItem(brick)
                brickBehavior.addItem(brick)
                
            }
            
        }
        
    } // end viewDidLoad()
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem, atPoint p: CGPoint) {
        
        for brick in brickBehavior.items as! [UIView] {
            
            if brick === item1 || brick == item2 as! UIView {
                
                brickBehavior.removeItem(brick)
                collision.removeItem(brick)
                brick.removeFromSuperview()
                
                topBar.score += 100
                
            }
            
        }
        
    } // end when 2 items contact
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, atPoint p: CGPoint) {
        
        
        if let idString = identifier as? String, let boundaryName = BoundaryType(rawValue: idString) {
            
            switch boundaryName {
                
            case .Ceiling : print("I can fly high")
                
            case .Floor : print("IT BURNS")
                
            case .LeftWall : print("Lefty")
                
            case .RightWall : print("Correct")
                
            }
            
        }
        
        
    } // end when item & boundary collision
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first {
            
            let point = touch.locationInView(view)
            attachment?.anchorPoint.x = point.x
            
        }
        
    } // end touches began
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first {
            
            let point = touch.locationInView(view)
            attachment?.anchorPoint.x = point.x
            
        }
        
    } // end touches moved
    

} // end class






