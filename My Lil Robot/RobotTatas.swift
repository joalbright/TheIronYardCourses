//
//  RobotTatas.swift
//  
//
//  Created by Heidi Proske on 9/5/14.
//
//

import UIKit

protocol RobotTatasDelegate {
    
    func minionSpottedEnemy(enemyDetails: NSDictionary)
}

class RobotTatas: RobotPart {
    
    var delegate:RobotTatasDelegate?
    
    let numMinions: Int = 10
    
    func getDistractMode() -> UIImage {
        return UIImage(named: "RobotTaTas")
    }
    
    func reportEnemy() {
        var enemyInfo: [String: Int] = Dictionary()
        enemyInfo["distance_miles"] = Int(arc4random_uniform(50)+50) // between 50..100
        enemyInfo["size_feet"] = Int(arc4random_uniform(5)+20)
        
        if (self.delegate != nil) {
            self.delegate?.minionSpottedEnemy(enemyInfo)
        }
    }
    
    func releaseMinionsToSearchForEnemies() {
        
        for index in 1...numMinions {
            
            let delayInSeconds = Double(index * 0.2);
            
            dispatch_after(
                dispatch_time(
                    DISPATCH_TIME_NOW,
                    Int64(delayInSeconds * Double(NSEC_PER_SEC))
                ),
                dispatch_get_main_queue(),  {
                    self.reportEnemy()
            })
        }
    }
}
