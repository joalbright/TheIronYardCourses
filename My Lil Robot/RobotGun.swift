//
//  RobotGun.swift
//  
//
//  Created by Joseph Lau on 9/5/14.
//
//

import Foundation

protocol RobotGunDelegate {
    
    func fire()
    func reload()
    func overheated()
    
}

class RobotShanker: RobotPart {
    
    var ammoCartridge: Int = 0
    var temperature: Int = 0
//    var gun:
    
    var delegate:RobotGunDelegate?
    
    func fire() {
        
    }
    
    func reload(ammoCount: Int) -> Bool {
        
        let maxAmmo = 250
        
        ammoCartridge += ammoCount
        
        if ammoCartridge > maxAmmo {
            ammoCartridge = maxAmmo
        }
        
        return ammoCartridge >= maxAmmo
    }
    
    func ammo() {
        
        ammoCartridge -= 10
        
        if ammoCartridge < 100 {
            
            if (self.delegate != nil) {
                self.delegate!.reload()
            }
            
        }
        
    }
    
    func overheated() -> Bool {
        let maxHeat = 5000
        
        return temperature >= maxHeat
    }
}
