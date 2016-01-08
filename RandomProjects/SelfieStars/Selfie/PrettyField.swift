//
//  PrettyField.swift
//  Selfie
//
//  Created by Jo Albright on 6/4/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

@IBDesignable class PrettyField: UITextField {
    
    @IBInspectable var cornerRadius: CGFloat = 10
    @IBInspectable var fillColor: UIColor = UIColor.clearColor()
    @IBInspectable var strokeColor: UIColor = DARK_BLUE
    @IBInspectable var strokeWidth: CGFloat = 1
    
    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
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
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset( bounds , 10 , 10 );
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset( bounds , 10 , 10 );
    }

}
