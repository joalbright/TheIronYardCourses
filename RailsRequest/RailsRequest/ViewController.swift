//
//  ViewController.swift
//  RailsRequest
//
//  Created by Jo Albright on 2/17/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let token = User.currentUser().token {
            
            println(token)
            
        } else {
            
            User.currentUser().getUserToken()
            
        }
        
    }


}

