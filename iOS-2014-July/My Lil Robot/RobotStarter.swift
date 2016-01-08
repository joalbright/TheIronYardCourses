//
//  Starter.swift
//  Parts
//
//  Created by Rene Candelier on 9/3/14.
//  Copyright (c) 2014 Novus Mobile. All rights reserved.
//

import UIKit

protocol robotStartDelegate{
    
    func selfDestruct()
    func overHeated()
    func lowFuel()
}

class Starter: RobotPart {
    
    
    var delegate:robotStartDelegate?
    
    
        var locationX = 20.0
    
         var locationY = 20.0
  
    
        var width = 20.0
    
       var height = 20.0
    
    var color = UIColor.redColor()
    
    
    
    
    
    func buttonPushedToStart(isOff:Bool)->Bool {
        
        
    if(isOff==true)
    {
        return true
    }
        
        else {return false}
    }
    
    
    func buttonPushedToStop(isOn:Bool)->Bool {
        
        if(isOn==true)
        {
            return true
        }
            
        else {return false}
    
    }
    
    
    func buttonPushedTwiceForSpecialMove(radius: Int) {
        
        
    }
    
    func buttonTwistedRight(radius: Int) {
        
        
    }
    
    func buttonTwistedLeft(radius: Int) {
        
        
    }
    
    
}
