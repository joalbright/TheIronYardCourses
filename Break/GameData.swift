//
//  GameData.swift
//  Break
//
//  Created by Jo Albright on 1/29/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

let _mainData: GameData = { GameData() }()

class GameData: NSObject {
   
    var topScore: Int = 0
    
    var gamesPlayed: [[String:Int]] = []
    var currentGame: [String:Int]? {
        
        get {
            
            return gamesPlayed[gamesPlayed.count - 1]
            
        }
        
        set {
            
            gamesPlayed[gamesPlayed.count - 1] = newValue!
            
        }
    
    }
    
    // (col,row)
    var allLevels = [
    
        (4,1),
        (6,2),
        (7,3),
        (8,4)
    
    ]
    
    var currentLevel = 0
    
    class func mainData() -> GameData { return _mainData }
    
    func startGame() {
        
        gamesPlayed.append([
            
            "livesLost":0,
            "bricksBusted":0,
            "levelBeaten":0,
            "totalScore":0
            
        ])
        
    }
    
    func adjustValue(difference: Int, forKey key: String) {
        
        if var value = currentGame?[key] {
            
            currentGame?[key] = value + difference
            
        }
        
    }
    
    
}

// GameData.mainData()