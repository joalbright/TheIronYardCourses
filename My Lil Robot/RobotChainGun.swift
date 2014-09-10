//
//  Robot Chain Gun.swift
//  
//
//  Created by Nick Peterson on 9/4/14.
//
//

import UIKit

protocol ChainGunDelegate {
    
    func overHeating()
    
    func overHeated()
    
    func lowAmmo()
    
    func showAmmo()
    
}

class RobotChainGun: RobotPart {
    
    var remainingAmmo: Int = 5000
    
    var temperature: Int = 73 // get chain gun temperature
    
    var rotation: Float = 0
    
    let maxRotation: Float = 45
    
    let ammoType: String = "7.62mm"
    
    let ammoPerSec: Int = 60
    
    let ammoSpeed: CGFloat = 600
    
    let ammoTail: String = "Flames"
    
    var delegate:ChainGunDelegate?
    
    
    func getAmmo(ammoAmount: Int) -> Bool {
        
        let maxAmmo = 10000
        
        remainingAmmo += ammoAmount
        
        if remainingAmmo > maxAmmo {
            
            remainingAmmo = maxAmmo
        }
        
        return remainingAmmo >= maxAmmo
        
    }
    
    func useAmmo() {
        
        remainingAmmo -= 1
        
        temperature += 2
        
        if remainingAmmo < 500 {
            
            if (self.delegate != nil) {
                
                self.delegate!.lowAmmo()
            }
        }
    }
    
    func isOverHeated() -> Bool {
        
        let maxHeat = 2250
        
        if temperature > 2000 {
            
            if (self.delegate != nil) {
                
                self.delegate!.overHeating()
            }
        }
        
        if temperature == maxHeat {
            
            if (self.delegate != nil) {
                
                self.delegate!.overHeated()
            }
        }
        
        return temperature >= maxHeat
    }
    
    func rotation(rotationAmount: Float) {
        
        rotation += rotationAmount
    }
}