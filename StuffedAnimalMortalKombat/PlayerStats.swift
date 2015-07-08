//
//  PlayerStats.swift
//  StuffedAnimalMortalKombat
//
//  Created by Jo Albright on 6/11/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

class PlayerStats: UIView {

    @IBOutlet weak var healthBar: StatsBar!
    @IBOutlet weak var energyBar: StatsBar!
    
    @IBOutlet weak var statsKills: StatsKills!
    @IBOutlet weak var statsLives: StatsLives!
    
    @IBOutlet weak var playerName: UILabel!

}
