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

let AUTH_URL = "https://foursquare.com/oauth2/authenticate?client_id=2LVLQ53AZFW4RN1WF15KNMVG0S0ZKKCPWD4DQH5TF5KNL0M0&response_type=token&redirect_uri=mayors://mayors.com"


class ViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBAction func foursquareConnect(sender: AnyObject) {
        
        if let url = NSURL(string: AUTH_URL) {
            
            UIApplication.sharedApplication().openURL(url)
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserverForName("FSConnectWithToken", object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            
            // code is ran after token is set
            
//            println(FoursquareModel.mainModel().token)
            
            let ME_URL = "https://api.foursquare.com/v2/users/self"
            
            let rManager = AFHTTPRequestOperationManager()
            
            rManager.GET(ME_URL, parameters: ["oauth_token":FoursquareModel.mainModel().token!,"v":"20150311","m":"foursquare"], success: { (operation, response) -> Void in
                
//                println(response)
                
//                let resultInfo = response as [String:AnyObject]
//                let responseInfo = resultInfo["response"] as [String:AnyObject]
//                let userInfo = responseInfo["user"] as [String:AnyObject]
//                
//                let firstName = userInfo["firstName"] as String
//                let lastName = userInfo["lastName"] as String
//                
//                self.welcomeLabel.text = "Welcome \(firstName) \(lastName)"
                
                let user = User(resultInfo: response as [String:AnyObject])
                
                self.welcomeLabel.text = "Welcome \(user.firstName) \(user.lastName)"
                
                
            }, failure: { (operation, error) -> Void in
                
                println(error)
                
            })
            
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

