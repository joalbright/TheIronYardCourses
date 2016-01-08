//
//  GuageView.swift
//  Robot
//
//  Created by Jeremy Butler on 9/4/14.
//  Copyright (c) 2014 Jeremy Butler. All rights reserved.
//

import UIKit

class GuageView: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    var pressure: CGFloat = 0.0
    
    
    func changePressure(newPressure: CGFloat) {
        
        pressure = newPressure
        self.setNeedsDisplay()
        
    }
    
    override func drawRect(rect: CGRect)
    {
        // Drawing code
        
        PressureStyleKit.drawGauge(pressure)
    }


}
