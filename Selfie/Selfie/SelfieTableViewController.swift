//
//  SelfieTableViewController.swift
//  Selfie
//
//  Created by Jo Albright on 10/30/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import UIKit
import Parse

class SelfieTableViewController: UITableViewController {

    var selfies: [PFObject] = []
    
    func logout() {
        
        PFUser.logOut()
        
        let userStoryboard = UIStoryboard(name: "User", bundle: nil)
        
        let nc = userStoryboard.instantiateInitialViewController()
        
        UIApplication.sharedApplication().windows.first?.rootViewController = nc
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
}
