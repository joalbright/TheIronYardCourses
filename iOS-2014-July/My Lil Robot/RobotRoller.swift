//
//  RoboRoller.swift
//  
//
//  Created by Arthur Boia on 9/4/14.
//
//

import UIKit

class RoboRoller: RobotPart {
    
    var speed : Int = 0
    var rotation : Float = 0
    var brakes: Float = 0
    var tiltangle: Float = 0
    
//    var delegate:RoboRollerDelegate?
    
    override func addPartToRobotAtPoint(robot: UIView, point: CGPoint) {
        
        super.addPartToRobotAtPoint(robot, point: point)
        
        // spin wheels for 1 second
        
    }
    
    func speedUp(speedIncrease: Int) -> Bool {
        
        let maxSpeed = 100
        
        speed += speedIncrease
        
        if speed == maxSpeed {
            [applyBrakes]
        }
        
        return true;
    }
    
    func rotateRoller (rotationAmount: Float){
        rotation += rotationAmount
    }
    
    func applyBrakes () -> Bool {
        
//        let maxSpeed <= 100
        
        return true;
    }
    
    func angle (tiltangle: Float) {
        
    }

}
