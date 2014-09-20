//
//  ViewController.swift
//  Robot
//
//  Created by Jeremy Butler on 9/4/14.
//  Copyright (c) 2014 Jeremy Butler. All rights reserved.
//

//- must be some part of a robot (RobotArm, RobotHead, RobotLeg, etc)
//- class must have 3 methods to make the part do something (ie : moveArmWithRadius(radius:Int) )
//- class must have 4 properties to customize the part ( fingerCount: Int, metalDensity: 10 )
//- class must have a delegate with 2 methods to update the robot of something happening

import UIKit

class ViewController: UIViewController {
                            
    @IBOutlet weak var gaugeView: GuageView!
    
    var timer: NSTimer!
    
    var pressure: CGFloat = 0.0
    var forward = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
//        var thing = PressureStyleKit.drawGauge(20.0)
        
//        self.view.addSubview(thing)
   

        // Do any additional setup after loading the view, typically from a nib.
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: Selector("randomlyChangeGauge"), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func randomlyChangeGauge() {
        
        pressure = forward ? pressure + 0.03 : pressure - 0.03
        
        if pressure >= 1.0 || pressure <= 0.0 {
            forward = !forward
        }
        
        self.gaugeView.changePressure(pressure)
        println(pressure)

    }

}

