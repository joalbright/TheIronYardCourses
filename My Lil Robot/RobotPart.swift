//
//  RobotPart.swift
//  My Lil Robot
//
//  Created by Jo Albright on 9/5/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

import UIKit

class RobotPart: UIView {
   
    func addPartToRobotAtPoint(robot: UIView, point: CGPoint) {
        
        robot.addSubview(self)
        self.center = point
        
    }
    
}
