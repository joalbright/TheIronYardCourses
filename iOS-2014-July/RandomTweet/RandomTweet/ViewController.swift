//
//  ViewController.swift
//  RandomTweet
//
//  Created by Jo Albright on 9/16/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

import UIKit
import Accounts
import Social
import SwifteriOS

class ViewController: UIViewController {
    
    var swifter: Swifter
    
    required init(coder aDecoder: NSCoder) {
        
        self.swifter = Swifter(consumerKey: "", consumerSecret: "")
        
        super.init(coder: aDecoder)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted: Bool, error: NSError!) -> Void in
            
            if granted {
                
                let twitterAccounts = accountStore.accountsWithAccountType(accountType)
                
                println(twitterAccounts)
                
                for tAccount in twitterAccounts {
                    
                    let tA = tAccount as ACAccount
                    
//                    println(tA.userFullName)
                    
                    println(tA.username) // Joalbright
                    
                    println(tA.accountDescription) // @Joalbright
                    
//                    println(tA.credential)
                    
                    println(tA.identifier) // token
                    
                }
                
                let twitterAccount = twitterAccounts[0] as ACAccount
                
                self.swifter = Swifter(account: twitterAccount)
                
//                self.swifter.postStatusUpdate("Im posting from an app I built with the new Swifter framework #iOS #swift", inReplyToStatusID: nil, lat: nil, long: nil, placeID: nil, displayCoordinates: false, trimUser: true, success: { (status) -> Void in
//                    
//                    
//                    
//                }, failure: { (error) -> Void in
//                    
//                })
                
                
//                self.swifter.getStatusesHomeTimelineWithCount(5, sinceID: nil, maxID: nil, trimUser: true, contributorDetails: true, includeEntities: true, success: { (statuses) -> Void in
//                    
//                    println(statuses)
//                    
//                }, failure: { (error) -> Void in
//                    
//                })
                
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

