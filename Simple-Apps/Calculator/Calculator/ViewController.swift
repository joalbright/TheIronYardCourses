//
//  ViewController.swift
//  Calculator
//
//  Created by Jo Albright on 9/21/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    
    
    @IBAction func pressZero(sender: AnyObject) {
        
        displayLabel.text = "0"
        
    }
    
    @IBAction func pressOne(sender: AnyObject) {
        
        displayLabel.text = "1"
        
    }
    
    @IBAction func doEquals(sender: AnyObject) {
        
        print("=")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

