//
//  Avatar.swift
//  StuffedAnimalMortalKombat
//
//  Created by Jo Albright on 6/10/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

@IBDesignable class Avatar: UIView {

    @IBInspectable var healthPoints: CGFloat = 60
    @IBInspectable var energyPoints: CGFloat = 80
    
    @IBInspectable var healthColor: UIColor = UIColor.greenColor()
    @IBInspectable var energyColor: UIColor = UIColor.purpleColor()
    
    @IBInspectable var lightHealth: UIColor = UIColor.lightGrayColor()
    @IBInspectable var lightEnergy: UIColor = UIColor.lightGrayColor()
    
    override func drawRect(rect: CGRect) {

        // piece of paper
        let context = UIGraphicsGetCurrentContext()
    
        // line width or bar width
        let lineWidth: CGFloat = 10
        CGContextSetLineWidth(context, lineWidth)
        
        // circle for the bar
        let barRect = CGRectInset(rect, lineWidth / 2, lineWidth / 2)
                
        // left bar
        lightHealth.set()
        CGContextStrokeEllipseInRect(context, barRect)

        // right bar
        CGContextSetBlendMode(context, kCGBlendModeSourceIn)
        lightEnergy.set()
        CGContextFillRect(context, CGRectMake(rect.width / 2, 0, rect.width / 2, rect.height))
        
        // remove other parts of circle
        CGContextSetBlendMode(context, kCGBlendModeClear)
        CGContextMoveToPoint(context, 0, 0) //tl
        CGContextAddLineToPoint(context, rect.width, 0) //tr
        CGContextAddLineToPoint(context, rect.width / 2, rect.height / 2) //c
        CGContextAddLineToPoint(context, rect.width, rect.height) //br
        CGContextAddLineToPoint(context, 0, rect.height) //bl
        CGContextAddLineToPoint(context, rect.width / 2, rect.height / 2) //c
        CGContextFillPath(context)
        
        // reset blend to normal
        CGContextSetBlendMode(context, kCGBlendModeNormal)
        
        // add bar rounded ends
        addDotAtDegrees(-135, withColor: lightHealth, andContext: context)
        addDotAtDegrees(135, withColor: lightHealth, andContext: context)
        addDotAtDegrees(-45, withColor: lightEnergy, andContext: context)
        addDotAtDegrees(45, withColor: lightEnergy, andContext: context)
        
        // add current health
        CGContextSetBlendMode(context, kCGBlendModeSourceIn)
        
        healthColor.set()
        
        let hDegrees = Double(((healthPoints / 100) * 90) + 135)
        
        let hAngle = CGFloat(DegreesToRadians(hDegrees))
        
        let hX = (rect.width / 2) + (rect.width) * cos(hAngle)
        let hY = (rect.height / 2) + (rect.height) * sin(hAngle)
        
        CGContextMoveToPoint(context, hX, hY)
        CGContextAddLineToPoint(context, rect.width / 2, rect.height / 2)
        CGContextAddLineToPoint(context, 0, rect.height)
        CGContextFillPath(context)
        
        addDotAtDegrees(hDegrees, withColor: healthColor, andContext: context)
        addDotAtDegrees(135, withColor: healthColor, andContext: context)

        // add current energy
        CGContextSetBlendMode(context, kCGBlendModeSourceIn)
        
        energyColor.set()
        
        let eDegrees = Double(45 - ((energyPoints / 100) * 90))
        
        let eAngle = CGFloat(DegreesToRadians(eDegrees))
        
        let eX = (rect.width / 2) + (rect.width) * cos(eAngle)
        let eY = (rect.height / 2) + (rect.height) * sin(eAngle)
        
        CGContextMoveToPoint(context, eX, eY)
        CGContextAddLineToPoint(context, rect.width / 2, rect.height / 2)
        CGContextAddLineToPoint(context, rect.width, rect.height)
        CGContextFillPath(context)
        
        addDotAtDegrees(eDegrees, withColor: energyColor, andContext: context)
        addDotAtDegrees(45, withColor: energyColor, andContext: context)
        
        
        CGContextSetBlendMode(context, kCGBlendModeNormal)
        
        // avatar circle
        UIColor.lightGrayColor().set()
        let avatarRect = CGRectInset(rect, 15, 15)
        CGContextFillEllipseInRect(context, avatarRect)
        
    }
    
    func addDotAtDegrees(degrees: Double, withColor color: UIColor, andContext context: CGContextRef) {
    
        let angle = CGFloat(DegreesToRadians(degrees))
        
        let x = (bounds.width / 2) + (bounds.width / 2 - 5) * cos(angle)
        let y = (bounds.height / 2) + (bounds.height / 2 - 5) * sin(angle)
        
        println("x \(x) y \(y)")
        
        color.set()
        CGContextSetLineCap(context, kCGLineCapRound)
        
        CGContextMoveToPoint(context, x, y)
        CGContextAddLineToPoint(context, x, y)
        
        CGContextStrokePath(context)
    
    }

}


