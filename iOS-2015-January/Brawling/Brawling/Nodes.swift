//
//  Nodes.swift
//  Brawling
//
//  Created by Jo Albright on 2/11/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import SpriteKit

class PlayerNode: SKSpriteNode {
    
    var player: Player?
    
}

class ProjectileNode: SKSpriteNode {
    
    var damage = 0
    var player: Player?
    
}
