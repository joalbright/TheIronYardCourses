//
//  ViewController.swift
//  Explore
//
//  Created by Jo Albright on 7/8/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit
import ExplorationTools

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let t = Tools.allTools().getName()
        
        print(t)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

