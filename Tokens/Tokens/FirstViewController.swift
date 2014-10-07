//
//  FirstViewController.swift
//  Tokens
//
//  Created by Jo Albright on 10/1/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

import UIKit


class FirstViewController: UIViewController {
    
    let API_URL = "https://api.foursquare.com/v2/"
    let CLIENT_ID = "2MJ4R0XEU4WQ1YUPUUHTS5FJFZL3A1H4PR1Z2BPI1AHUEHOE"
    
    @IBOutlet weak var fsConnect: UIButton!
    
    var token: String = "" {
        
        willSet(newToken) {

            println(newToken)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if defaults.objectForKey("FS_TOKEN") != nil {
            
//            fsConnect.alpha = 0
            
            FS_TOKEN = defaults.objectForKey("FS_TOKEN")! as String
            
        }
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIApplicationDidBecomeActiveNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            
            let defaults = NSUserDefaults.standardUserDefaults()
            
            println(defaults.objectForKey("FS_TOKEN"))
            
            if defaults.objectForKey("FS_TOKEN") != nil {
                
//                self.fsConnect.alpha = 0
                
            }
            
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    @IBAction func foursquareConnect(sender: AnyObject) {
        
        let AUTH_URL = "https://foursquare.com/oauth2/authenticate?client_id=" + CLIENT_ID + "&response_type=token&redirect_uri=tokens://tokens.com"
        
        UIApplication.sharedApplication().openURL(NSURL(string: AUTH_URL))
        
    }
    
    @IBAction func findLocations(sender: AnyObject) {
        
//        foursquareRequest("venues/search", parameter: "near=Buckhead,GA")
        foursquareRequest("venues/search", parameter: "near=Buckhead,GA") { (resultInfo) -> [AnyObject] in
            
            return resultInfo["response"]!["venues"]! as [AnyObject]
            
        }
        
    }
    
    @IBAction func findWaldo(sender: AnyObject) {
        
//        foursquareRequest("users/search", parameter: "name=waldo")
        foursquareRequest("users/search", parameter: "name=waldo") { (resultInfo) -> [AnyObject] in
            
            return resultInfo["response"]!["results"]! as [AnyObject]
 
        }
        
    }
    
    func foursquareRequest(endpoint: String, parameter: String, completion: (resultInfo:[String:AnyObject]) -> [AnyObject]) {
        
        var request = NSURLRequest(URL: NSURL(string: API_URL + endpoint + "?oauth_token=" + FS_TOKEN + "&v=20141001&" + parameter ))
        
        println(request.URL.absoluteString)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            
            var resultInfo = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.allZeros, error: nil) as [String:AnyObject]
            
            
            var fsTVC = self.storyboard!.instantiateViewControllerWithIdentifier("foursquareTVC") as FSTableViewController
            
            fsTVC.items = completion(resultInfo: resultInfo)
            
            self.presentViewController(fsTVC, animated: true, completion: nil)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

