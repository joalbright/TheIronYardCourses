//
//  ViewController.swift
//  SwiftApp
//
//  Created by Jo Albright on 1/26/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

let RED = UIColor.redColor()
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.height

class ViewController: UIViewController {
    
    var viewColor = RED
    
    var firstName = ""
    var lastName = ""
    
    var name: String {
        
        get {
            
            return firstName + " " + lastName
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstName = "Jo"
        lastName = "Albright"
        
        println(name)
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

