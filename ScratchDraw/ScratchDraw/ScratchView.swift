//
//  ScratchView.swift
//  ScratchDraw
//
//  Created by Jo Albright on 5/14/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

class ScratchView: UIView {

    var currentColor = UIColor.blackColor()

    var scratches: [Scratch] = []
    
    override func drawRect(rect: CGRect) {

        var context = UIGraphicsGetCurrentContext()
        
        CGContextSetLineWidth(context, 5.0)
        CGContextSetLineCap(context, kCGLineCapRound)
        
//        UIColor.blackColor().set()
        
        for scratch in scratches {
            
            if let firstPoint = scratch.points.first {
            
                if let strokeColor = scratch.strokeColor {
                    
                    strokeColor.set()
                    
                    CGContextMoveToPoint(context, firstPoint.x, firstPoint.y)
                    
                    for point in scratch.points {
                        
                        CGContextAddLineToPoint(context, point.x, point.y)
                        
                    }
                    
                    CGContextStrokePath(context)
                    
                }
                
            }
            
        }
    
    }
    
    func newScratchWithStartPoint(point: CGPoint) {
        
        var scratch = Scratch()
        scratch.points = [point,point]
        
        scratch.strokeColor = currentColor
        
        scratches.append(scratch)
        setNeedsDisplay()
        
    }
    
    func updateCurrentScratchWithLastPoint(point: CGPoint) {
        
        if scratches.last != nil {
            
            scratches[scratches.count - 1].points[1] = point
            setNeedsDisplay()
            
        }
        
    }
    
    func addPointToCurrentScratch(point: CGPoint) {
        
        if scratches.count > 0 {
            
            scratches[scratches.count - 1].points.append(point)
            setNeedsDisplay()
            
        }
        
    }

}

class Scratch {
    
    var points: [CGPoint] = []
    var fillColor: UIColor?
    var strokeColor: UIColor?
    var strokeSize: Double = 0
    
    // line dash
    
    // line cap
    // line join
    
}





