//
//  Game.swift
//  Brawling
//
//  Created by Jo Albright on 2/11/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

private let _mainGame = Game ()

class Game: NSObject {
    
    var players: [Player] = []
    
    class func mainGame() -> Game { return _mainGame }
    
    func findPlayerWithDisplayName(displayName: String) -> Player? {
        
        for player in players {
            
            if displayName == player.displayName { return player }
            
        }
        
        return nil
        
    }
    
}
