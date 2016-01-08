//
//  ViewController.swift
//  TouchyDot
//
//  Created by Jo Albright on 12/3/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import UIKit
import iAd

class ViewController: UIViewController, ADBannerViewDelegate {

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bannerView: ADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomConstraint.constant = -bannerView.frame.height
        
        // create and run nstimer that will trigger pingDot
        
    }
    
    // add button to storyboard for leaderboard
    // add action for leaderboard button
    
    // add label to storyboard for currentscore
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        
        bottomConstraint.constant = 0
        
        UIView.animateWithDuration(0.4) { () -> Void in
            
            self.view.layoutIfNeeded()
            
        }
        
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        
        bottomConstraint.constant = -bannerView.frame.height

        UIView.animateWithDuration(0.4) { () -> Void in
            
            self.view.layoutIfNeeded()
            
        }
        
    }
    
    var correctDot = -1
    var currentScore = 0
    var dotTimer: NSTimer?
    
    @IBAction func touchDot(dot: TouchButton) {
        
        // check if correctDot == dot.tag
        // true : currentScore++
        // false : currentScore = 0
        
        // update score label
        
        switch dot.tag {
            
        case 0: print("top left")
        case 1: print("top right")
        case 2: print("bottom left")
        case 3: print("bottom right")
        default: print("bad touch")
            
        }
        
    }
    
    func pingDot() {
        
        // choose random dot
        // make dot flash another color
        // set correctDot to the random dot
        
    }
    

}

