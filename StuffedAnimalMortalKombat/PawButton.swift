//
//  PawButton.swift
//  StuffedAnimalMortalKombat
//
//  Created by Jo Albright on 6/11/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

@IBDesignable class PawButton: UIButton {

    @IBInspectable var fillColor: UIColor = UIColor.cyanColor()
    @IBInspectable var pawColor: UIColor = UIColor.whiteColor()
    
    @IBInspectable var pawInset: CGFloat = 0
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        let scaleX = (rect.width - pawInset * 2) / 250
        let scaleY = (rect.height - pawInset * 2) / 250
        
        let context = UIGraphicsGetCurrentContext()
        
        fillColor.set()
        
        CGContextFillEllipseInRect(context, rect)
        
        CGContextTranslateCTM(context, pawInset, pawInset)
        CGContextScaleCTM(context, scaleX, scaleY)
        
        pawColor.set()
        
        
        let circles: [(CGFloat,CGFloat,CGFloat)] = [
        
            (133.6, 158.5, 63.6),
            (208.0, 85.4, 19.7),
            (42.0, 114.0, 19.7),
            (153.9, 54.2, 25.4),
            (82.4, 62.2, 28.3)
        
        ]
        
        for (cx,cy,r) in circles {
            
            CGContextFillEllipseInRect(context, CGRectMake(cx - r, cy - r, r * 2, r * 2))
            
        }
        
    }

}
