//
//  MoveButton.swift
//  StuffedAnimalMortalKombat
//
//  Created by Jo Albright on 6/11/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

@IBDesignable class MoveButton: UIButton {
    
    @IBInspectable var fillColor: UIColor = UIColor.cyanColor()
    @IBInspectable var arrowColor: UIColor = UIColor.whiteColor()
    
    @IBInspectable var topInset: CGFloat = 10
    @IBInspectable var bottomInset: CGFloat = 10
    @IBInspectable var leftInset: CGFloat = 10
    @IBInspectable var rightInset: CGFloat = 10
    
    @IBInspectable var curveAmount: CGFloat = 10
    
    @IBInspectable var rotation: Double = 0

    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
        fillColor.set()
        
        
        CGContextTranslateCTM(context, rect.width / 2, rect.height / 2)
        CGContextRotateCTM(context, CGFloat(DegreesToRadians(rotation)))
        CGContextTranslateCTM(context, rect.width / -2, rect.height / -2)
        
        CGContextFillEllipseInRect(context, rect)
        
        
        arrowColor.set()
        
        CGContextMoveToPoint(context, leftInset, rect.height - bottomInset)
        CGContextAddLineToPoint(context, rect.width / 2, topInset)
        CGContextAddLineToPoint(context, rect.width - rightInset, rect.height - bottomInset)
        
        let third = (rect.width - rightInset - leftInset) / 3
        
        CGContextAddCurveToPoint(context, rect.width - rightInset - third, rect.height - bottomInset - curveAmount, leftInset + third, rect.height - bottomInset - curveAmount, leftInset, rect.height - bottomInset)
        
        CGContextFillPath(context)
        
        
    }

}
