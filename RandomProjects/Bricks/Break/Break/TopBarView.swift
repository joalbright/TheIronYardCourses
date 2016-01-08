//
//  TopBarView.swift
//  Break
//
//  Created by Jo Albright on 10/8/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import UIKit

class TopBarView: UIView {

    var lives: Int = 0 {
        
        didSet {
            
            // remove current circles
            for circle in lifeView.subviews {
                
                circle.removeFromSuperview()
                
            }
            
            // add circles based on life count
            
            for l in 0..<lives {
                
                let circleTotal = lives * 10 + (lives - 1) * 5
                
                let circle = UIView(frame: CGRect(x: l * 15 - (circleTotal / 2), y: Int(lifeView.center.y) - 5, width: 10, height: 10))
                
                circle.layer.cornerRadius = 5
                circle.backgroundColor = UIColor.whiteColor()
                
                lifeView.addSubview(circle)
                
            }
            
        }
        
    }
    
    var score: Int = 0 {
        
        didSet {
            
            scoreLabel.text = "\(score)"
            
        }
        
    }
    
    private let titleLabel = UILabel(frame: CGRectMake(10, 0, 100, 50))
    private let scoreLabel = UILabel(frame: CGRectMake(0, 0, 100, 50))
    private let lifeView = UIView(frame: CGRectMake(0, 0, 0, 50))
    
    override func didMoveToSuperview() {
        
        score = 0
        
        lives = 3
        lives = 4
        
        titleLabel.text = "BREAK"
        titleLabel.textColor = UIColor.whiteColor()
        
        scoreLabel.frame.origin.x = frame.width - 110
        scoreLabel.textColor = UIColor.whiteColor()
        scoreLabel.textAlignment = .Right
        
        lifeView.center.x = center.x
        
        addSubview(titleLabel)
        addSubview(scoreLabel)
        addSubview(lifeView)
        
    }
    
}
