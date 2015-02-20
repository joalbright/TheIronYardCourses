//
//  DeltaView.swift
//  MotionSickness
//
//  Created by Jo Albright on 2/16/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

class DeltaView: UIView {

    var deltaPoint: (CGFloat,CGFloat)? {
        
        didSet { setNeedsDisplay() }
        
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        var context = UIGraphicsGetCurrentContext()
        
        CGContextSetLineWidth(context, 1)
        UIColor.lightGrayColor().set()
        
        CGContextStrokeEllipseInRect(context, CGRectInset(rect, rect.width / 4, rect.height / 4))
        
        
        var point = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))
        
        if let (x,y) = deltaPoint {
            
            point.x += x
            point.y += y
            
        }
        
        CGContextSetLineWidth(context, 5)
        CGContextSetLineCap(context, kCGLineCapRound)
        UIColor.redColor().set()
        
        CGContextMoveToPoint(context, point.x, point.y)
        CGContextAddLineToPoint(context, point.x, point.y)
        
        CGContextStrokePath(context)
        
    }

}







