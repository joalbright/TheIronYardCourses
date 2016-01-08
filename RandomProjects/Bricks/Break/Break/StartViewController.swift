//
//  StartViewController.swift
//  Break
//
//  Created by Jo Albright on 10/8/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBAction func play(sender: AnyObject) {
        
        let gameVC = GameViewController()
        navigationController?.viewControllers = [gameVC]
        
    }
    
}
