//
//  BrickView.swift
//  Smash
//
//  Created by Jo Albright on 5/19/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

class BrickView: UIView {

    var points = 0
    
    var health = 0 {
        
        didSet {
            
            if points == 0 { points = health * 100 }
            setNeedsDisplay()
            
        }
        
    }
    
    override func drawRect(rect: CGRect) {
        
        var context = UIGraphicsGetCurrentContext()
        
        UIColor(white: 0.0, alpha: 0.3 * CGFloat(health) + 0.1).set()
        
        CGContextFillRect(context, rect)
        
    }

}
