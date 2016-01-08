//
//  ViewController.swift
//  RailsRequest
//
//  Created by Jo Albright on 2/17/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

/// where your games playing or create a game
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let token = User.currentUser().token {
            
            println(token)
            
        } else {
            
            // show login view controller
            
            var loginVC = LoginController()
            presentViewController(loginVC, animated: false, completion: nil)
            
        }
        
    }
    
    // called by new game button
    func newGame() {
        
        
        
    }

}

class LoginController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    // called by login button
    func login() {
        
        User.currentUser().login("jo@blah.com", password: "pasword")
        
    }
    
    // called by register button
    func register() {
        
        User.currentUser().register("teach", email: "jo@blah.com", password: "pasword")
        
    }
    
}





