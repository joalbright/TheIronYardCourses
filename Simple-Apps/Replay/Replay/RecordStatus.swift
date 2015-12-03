//
//  RecordStatus.swift
//  Replay
//
//  Created by Jo Albright on 11/12/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import UIKit

@IBDesignable class RecordStatus: UIView {

    @IBInspectable var isRecording: Bool = false {
        
        didSet { setNeedsDisplay() }
        
    }
    
    var centerColor: UIColor {
        
        return isRecording ? UIColor.redColor() : UIColor.blackColor()
        
    }
    
    override func drawRect(rect: CGRect) {

        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetLineWidth(context, 2)
        
        UIColor(white: 0, alpha: 0.4).set()
     
        CGContextStrokeEllipseInRect(context, CGRectInset(rect, 1, 1))
        
        print(isRecording)
        
        centerColor.set()
        
        CGContextFillEllipseInRect(context, CGRectInset(rect, 4, 4))
    
    }

}
