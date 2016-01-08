//
//  PrettyButton.swift
//  Selfie
//
//  Created by Jo Albright on 6/4/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

@IBDesignable class PrettyButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 10
    @IBInspectable var fillColor: UIColor = UIColor.clearColor()
    @IBInspectable var strokeColor: UIColor = DARK_BLUE
    @IBInspectable var strokeWidth: CGFloat = 1
    
    override func drawRect(rect: CGRect) {

        var context = UIGraphicsGetCurrentContext()
        
        let insetRect = CGRectInset(rect, strokeWidth / 2, strokeWidth / 2)
        
        let path = UIBezierPath(roundedRect: insetRect, cornerRadius: cornerRadius)
        
        fillColor.set()
        
        CGContextAddPath(context, path.CGPath)
        CGContextFillPath(context)
        
        strokeColor.set()
        
        CGContextSetLineWidth(context, strokeWidth)
        CGContextAddPath(context, path.CGPath)
        CGContextStrokePath(context)
        
    
    }

}




