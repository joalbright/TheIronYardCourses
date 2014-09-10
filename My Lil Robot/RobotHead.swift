//
//  RobotHead.swift
//  DynamicsDemo
//
//  Created by Steve Sneller on 9/4/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import UIKit

protocol RobotHeadDelegate {
    func explodes()
    func overHeated()
    func lowFuel()
    func failure()
}

class RobotHead: RobotPart {
 
        var eyeDiameter: Int = 2
        var earDiameter: Int = 4
        var mouthDiameter: Int = 3
        var headWidth: Int = 100

        var delegate:RobotHeadDelegate? // //
    
    
    func growMouth() {
        mouthDiameter += 5
        if mouthDiameter > 50 {
            mouthDiameter = 2
        }
    }
    
    func growEyes() {
        eyeDiameter += 1
        if eyeDiameter > 30 {
            eyeDiameter = 2
        }
    }
    
    func growEars() {
        earDiameter += 1
        if earDiameter > 10 {
            earDiameter = 2
        }
    }
    
    func changeHeadWidth() {
        earDiameter += 1
        if earDiameter > 10 {
            earDiameter = 2
        }
    }
}
