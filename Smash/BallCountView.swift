//
//  BallCountView.swift
//  Smash
//
//  Created by Jo Albright on 5/19/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

class BallCountView: UIView {

    var ballsLeft = 3 {
        
        didSet {
            
            setNeedsDisplay()
            
        }
        
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        var context = UIGraphicsGetCurrentContext()
        
        let height
        
        for i in 0..<ballsLeft {
            
            
            
        }
        
    }

}
