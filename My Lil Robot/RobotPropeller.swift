//
//  RobotThruster.swift
//
//
//  Created by KaL on 9/4/14.
//
//

import UIKit

protocol RobotPropellerDelegate {
    // custom protocol
    // rules set for the thruster to tell the main robot
    func explodes()
    func overHeated()
    func lowFuel()
    func failure()
}

class RobotPropeller: RobotPart {
    
    var fuelLevel: Int = 0
    
    //     var fuelLevel: Int! or var fuelLevel: Int? as the instance
    //    var fuelLevel = 0 as Int
    
    //    Int fuelLevel = 0;
    
    // part is the wild card
    
    // @interface and @end is the actual class
    
    var fuelType: String = "Diesel"
    var temperature: Int = 0 // get robot temperature
    var rotation: Float = 0
    var emmissionType: String = "Bubbles"
    
    var delegate:RobotPropellerDelegate?
    
    // optional allows it to be not set right away
    
    func addFuel(fuelAmount: Int) -> Bool {
        // add some fuel and return a bool to decide whether or not its true
        
        let maxFuel = 250
        
        fuelLevel += fuelAmount
        
        if fuelLevel > maxFuel {
            fuelLevel = maxFuel
        }
        
        return fuelLevel >= maxFuel
        
    }
    
    func useFuel() {
        
        fuelLevel -= 10
        
        if fuelLevel < 50 {
            
            if (self.delegate != nil) {
                self.delegate!.lowFuel()
                
            }
        }
    }
    
    
    func isOverHeated() -> Bool {
        
        let maxHeat = 5000
        
        return temperature >= maxHeat
    }
    
    func rotatePropeller(rotationAmount: Float){
        
        rotation += rotationAmount
    }
}
