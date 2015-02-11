//
//  Player.swift
//  Brawling
//
//  Created by Jo Albright on 2/11/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

class Player: NSObject {
    
    var healthPoints = 100
    var displayName = ""
    var skin: UIImage?
    
    func attackWithDamage(damage: Int) {
        // damage reduction based on armor powerup
        
        healthPoints -= damage
        
        println(displayName + " has \(healthPoints) left")
        
    }
   
}
