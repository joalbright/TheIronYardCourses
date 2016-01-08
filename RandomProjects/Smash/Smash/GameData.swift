//
//  GameData.swift
//  Smash
//
//  Created by Jo Albright on 5/20/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

private let _data = GameData()

class GameData: NSObject {
    
    class func mainData() -> GameData { return _data }
    
    var currentLevel = 0
    var currentLives = 0
    var currentScore = 0
    
    var levels: [[[Int]]] = [
    
    
        [
            [2,3,2],
            [1,2,0,2,1]
        ],
        
        [
            [2,3,2],
            [1,1,1,1,1],
            [1,0,2,0,1]
        ]
        
    
    ]
    
    var playerInfo: [String:AnyObject] = [
    
        "ballsLost" : 0,
        "levelsBeat" : 0,
        "topScore" : 0
    
    ]
   
    func getCurrentLevelBricks() -> [[Int]] {
        
        return levels[currentLevel]
        
    }
    
}







