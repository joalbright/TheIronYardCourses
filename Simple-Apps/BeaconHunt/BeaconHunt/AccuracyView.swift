//
//  AccuracyView.swift
//  BeaconHunt
//
//  Created by Jo Albright on 11/10/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import UIKit

@IBDesignable class AccuracyView: UIView {
    
    var beaconColor: UIColor = UIColor.lightGrayColor() {
        
        didSet { setNeedsDisplay() }
        
    }

    override func drawRect(rect: CGRect) {

        let context = UIGraphicsGetCurrentContext()
        
        beaconColor.set()
        
        let insetRect = CGRectInset(rect, 1, 1)
        
        CGContextStrokeEllipseInRect(context, insetRect)
    
    }

}
