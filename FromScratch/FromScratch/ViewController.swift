//
//  ViewController.swift
//  FromScratch
//
//  Created by Jo Albright on 5/7/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        for touch in touches as! Set<UITouch> {
            
            let location = touch.locationInView(view)
            
            println("x = \(location.x) and y = \(location.y)")
            
            var box = CrazyThing()
            view.addSubview(box)
            box.center = location

        }
        
    }

}

