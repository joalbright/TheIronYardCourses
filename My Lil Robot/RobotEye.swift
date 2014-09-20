//
//  RobotEye.swift
//  robotpart
//
//  Created by Merritt Tidwell on 9/5/14.
//  Copyright (c) 2014 Merritt Tidwell. All rights reserved.
//

import UIKit

enum EyeColor: Int {
    case Red
    case Blue
    case Green
}

protocol RobotEyeDelegate {
    
    func eyeMalfunction(foreignObject: NSObject)
}

class RobotEye: RobotPart {
    
    var pupilSize: Int = 5
    
    var eyeColor: UIColor = UIColor.blackColor()
    
    var delegate:RobotEyeDelegate?
    
    func changePupilSize(amount: Int) {
        
        let min = 2
        let max = 20
        
        pupilSize += amount
        
        if (pupilSize < min) {
            pupilSize = min
        }
        
        if (pupilSize > max) {
            pupilSize = max
        }
        
    }
    
    func changeEyeColor(newColor: EyeColor) {
        
        switch (newColor) {
            
        case EyeColor.Red:
            eyeColor = UIColor.redColor()
            
        case EyeColor.Blue:
            eyeColor = UIColor.blueColor()
            
        case EyeColor.Green:
            eyeColor = UIColor.greenColor()
            
        }
        
        let randomChance = Int(arc4random_uniform(2)) // gen a 0 or 1
        
        if randomChance == 1 { //randomly tell parent got a problem!
            if (self.delegate != nil) {
                self.delegate?.eyeMalfunction(NSObject())
            }
        }
        
    }
    
}