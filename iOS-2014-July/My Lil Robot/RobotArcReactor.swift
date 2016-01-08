//
//   RobotArcReactor.swift
//  
//
//  Created by Daniel Merrill on 9/4/14.
//
//

//I want everyone to build a simple class based on NSObject (in Swift)   √
//- must be some part of a robot (RobotArm, RobotHead, RobotLeg, etc)     √
//- class must have 3 methods to make the part do something (ie : moveArmWithRadius(radius:Int) )
//- class must have 4 properties to customize the part ( fingerCount: Int, metalDensity: 10 )
//- class must have a delegate with 2 methods to update the robot of something happening

import UIKit


protocol RobotArcReactorDelegate {
    
    func rusts()
    func palladiumErosion()
    func lowPower()
    func failure()
    
    
    // palladium continuously eroded by the neutron bombardment which resualts in rusting(poisoning) in order to prevent rusting(poisoning) then change Palladium core.

}


class  RobotArcReactor: RobotPart {
    
    var powerCapacity: Int = 0
    
    
    var powerType: String = "Cold Fusion/Palladium"
    
    var palladiumStability: Int = 0
    
    var reactorRadiate: String = "Perpetual Beam of Blue Light"
    
    
    //Palladium Stability = "temperature"
    
//    var fuelLevel : Int = 0 √
//    
//    var fuelType : String = "Diesel"   √
//    
//    var temperature : Int = 0 // get robot temperature  √
//    
//    var rotation : Float = 0  ????
//
//    var emissionType: String = "Bubbles"    √
    
    var delgate: RobotArcReactorDelegate?
    
    override func addPartToRobotAtPoint(robot: UIView, point: CGPoint) {
        
        super.addPartToRobotAtPoint(robot, point: point)
        
        // slowly spin arc reactor
        
    }
    
    func powerRegeneration(powerAmount: Int) -> Bool {
        
        let maxPower = 1000
        
        powerCapacity += powerAmount
        
        if powerCapacity > maxPower {
            
            powerCapacity = maxPower
        }
        
        self.alpha += 0.1
        
        
        return powerCapacity >= maxPower
    }
    
    func usePower() {
        
        powerCapacity -= 10
        
        self.alpha -= 0.1
        
        if powerCapacity < 100 {
            
            if (self.delgate != nil) {
                
                self.delgate!.lowPower()
                
            }
            
        }
        
    }
    
    
    func  hasPalladiumErosion() -> Bool {
        
        let maxPotentialErosion = 80
        
        return palladiumStability >= maxPotentialErosion
        
    }


    
}

class Robot: NSObject, RobotArcReactorDelegate {
    
    func addPart(part: AnyObject!) {
        
        
        if part is RobotArcReactor {
            
            let arcReactor = part as RobotArcReactor
            
            arcReactor.delgate = self
            
        }
        
    }
    
    func rusts() {
        
    }
    
    func palladiumErosion() {
        
    }
    
    func lowPower() {
        
    }
    
    func failure() {
        
    }
    
}


