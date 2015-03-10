//
//  ViewController.swift
//  Mayors
//
//  Created by Jo Albright on 3/5/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit
import Crashlytics
//import AFNetworking

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//         Do any additional setup after loading the view, typically from a nib.
        
        let manager = AFHTTPRequestOperationManager()
        
        
        manager.GET("http://jo2.co/twitter.json", parameters: nil, success: { (operation, responseObject) -> Void in
            
            println(responseObject)
            
        }) { (operation, error) -> Void in
            
            println(error)
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

