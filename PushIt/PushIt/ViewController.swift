//
//  ViewController.swift
//  PushIt
//
//  Created by Jo Albright on 3/2/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserverForName("Push Touch", object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            
            let x = (notification.userInfo!["x"] as NSString).floatValue
            let y = (notification.userInfo!["y"] as NSString).floatValue
            
            let center = CGPointMake(CGFloat(x), CGFloat(y))
            
            let touchView = UIView(frame: CGRectMake(0, 0, 0, 0))
            touchView.center = center
            touchView.backgroundColor = UIColor.magentaColor()
            self.view.addSubview(touchView)
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                
                touchView.frame = CGRectMake(0, 0, 100, 100)
                touchView.center = center
                touchView.alpha = 0
                
            }, completion: { (success) -> Void in
                
                touchView.removeFromSuperview()
                
            })
            
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        if let touch = touches.allObjects.last as? UITouch {
            
            let location = touch.locationInView(view)
            
            let push = PFPush()
            
            push.setData(["alert":"Push Touch","x":"\(location.x)","y":"\(location.y)"])
            
            push.sendPushInBackgroundWithBlock(nil)
            
            
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
