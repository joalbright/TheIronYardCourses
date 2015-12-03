//
//  TouchButton.swift
//  TouchyDot
//
//  Created by Jo Albright on 12/3/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import UIKit

@IBDesignable class TouchButton: UIButton {
    
    @IBInspectable var color: UIColor = UIColor.blackColor()
    
    @IBInspectable var spacing: CGFloat = 1
    
    @IBInspectable var maxRings: Int = 0

    override func drawRect(rect: CGRect) {

        print(maxRings)
        
        if spacing < 1 { spacing = 1 }
        if maxRings < 1 { maxRings = 1000 }
        
        let context = UIGraphicsGetCurrentContext()
        let radius = rect.width / 2
        var inset: CGFloat = 1
        
        color.set()
        
        var ringCount = 0
        
        while inset < radius {
            
            if ringCount == maxRings { inset = radius }
            
            let insetRect = CGRectInset(rect, inset, inset)
            
            CGContextStrokeEllipseInRect(context, insetRect)
            
            ringCount++
            inset += spacing
            
        }
    
    }

}
