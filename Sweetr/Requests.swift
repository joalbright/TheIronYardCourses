//
//  Requests.swift
//  Sweetr
//
//  Created by Jo Albright on 5/18/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import Foundation
import CoreLocation

class FourSquareRequest {
    
    let API_URL = "https://api.foursquare.com/v2/"
    let CLIENT_ID = "5MXUODIJJ0PWRB05NDV5EF51XSQ44YZZ32U2MIKXTKDK0SDL"
    let CLIENT_SECRET = "NNYQJYG4LQZ2WDRPRMOFL5PBKNC31BZ2WODYOPACPJ3J3U3L"
    
    func getVenuesWithLocation(location: CLLocation, completion: (venues: [AnyObject]) -> Bool) {

        
        // venues empty array
        var venues: [AnyObject] = []
        
        // run completion closure/block and pass venues array
        var usedVenues = completion(venues: venues)
        
    }
    
}

class TwitterRequest {
    
    let API_URL = "https://api.twitter.com/1.1/"
    let API_KEY = "zhxFFFtwMBT9F8roBGwsZLThl"
    let API_SECRET = "Vjo51dD8OJp4Anj5C9ImtBzNqGeV1fQXTbazrLxSpSu4LovwkP"
    
    var API_ENCODED: String? {
        
        get {
            
            let str = API_KEY + ":" + API_SECRET
            
            let utf8str = str.dataUsingEncoding(NSUTF8StringEncoding)
            
            if let encoded = utf8str?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.allZeros) {
                
                return "Basic " + encoded
                
            }
            
            return nil
            
        }
        
    }
    
    var TOKEN: String? {
        
        get {
        
           return NSUserDefaults.standardUserDefaults().objectForKey("twitterToken") as? String
            
        }
        
        set {
            
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "twitterToken")
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }
        
    }
    
    func getToken(completion: () -> ()) {
        
        let endpoint = "https://api.twitter.com/oauth2/token?grant_type=client_credentials"
        
        if let url = NSURL(string: endpoint) {
            
            var request = NSMutableURLRequest(URL: url)
            
            request.HTTPMethod = "POST"
            
            request.setValue(API_ENCODED, forHTTPHeaderField: "Authorization")
            
            request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) -> Void in
                
                var error: NSError? = nil
                
                if let returnInfo = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as? [String:AnyObject] {
                    
                    println(returnInfo)
                    
                    self.TOKEN = returnInfo["access_token"] as? String
                    
                    completion()
                    
                }
                
                if let error = error {
                    
                    println(error)
                    
                }
                
            })
            
        }
    
    }
    
    func findPopularFoodTweets(completion: (tweets: [AnyObject]) -> ()) {
        
        if TOKEN == nil {
            
            getToken({ () -> () in
                
                // do something
                self.findPopularFoodTweets(completion)
                
            })
            
            return
            
        }
        
        
        let endpoint = API_URL + "search/tweets.json?q=Food&result_type=popular"
        
        
        if let url = NSURL(string: endpoint) {
            
            let request = NSMutableURLRequest(URL: url)
            
            request.setValue("Bearer " + TOKEN!, forHTTPHeaderField: "Authorization")
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) -> Void in
                
                
                var error: NSError? = nil
                
                if let searchInfo = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as? [String:AnyObject] {
                    
                    if let tweets = searchInfo["statuses"] as? [AnyObject] {
                        
                        completion(tweets: tweets)
                        
                    }
                    
                    
                }
                
                if let error = error {
                    
                    println(error)
                    
                }
                
            })
            
        }
        
    }
    
    
}

