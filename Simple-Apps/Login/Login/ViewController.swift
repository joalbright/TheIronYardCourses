//
//  ViewController.swift
//  Login
//
//  Created by Jo Albright on 10/15/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var lockedStatusLabel: UILabel!
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if PFUser.currentUser() != nil {
            
            // logged in
            
        } else {
            
            // not logged in
            
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            
            if let loginVC = storyboard.instantiateInitialViewController() {
                
                presentViewController(loginVC, animated: true, completion: nil)
                
            }
            
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

