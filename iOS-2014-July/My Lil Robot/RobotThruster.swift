//
//  RobotThruster.swift
//  
//
//  Created by Jo Albright on 9/4/14.
//
//

import UIKit

protocol RobotThrusterDelegate {
    
    func explodes()
    func overHeated()
    func lowFuel()
    func failure()
    
}

class RobotThruster: RobotPart {
    
    var fuelLevel: Int = 0
    var temperature: Int = 0 // get robot temperature
    var rotation: Float = 0
    var fuelType: String = "Diesel"
    var emissionType: String = "Bubbles"
    
    var delegate:RobotThrusterDelegate?
   
    func addFuel(fuelAmount: Int) -> Bool {
        
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
    
    func rotateThruster(rotationAmount: Float) {
        
        rotation += rotationAmount
        
    }
}
