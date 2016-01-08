//
//  API.swift
//  RailsRequest
//
//  Created by Jo Albright on 2/17/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import Foundation

let API_URL = "https://pure-anchorage-3070.herokuapp.com/"

typealias ResponseBlock = (responseInfo: [String:AnyObject]) -> ()

class APIRequest {
    
    // (responseInfo: [String:AnyObject]) -> ()
    
    class func requestWithEnpoint(endpoint: String, method: String, completion: ResponseBlock) {
        
        var options = [
        
            "endpoint" : endpoint,
            "method" : method,
            "body" : [
            
                "user" : [ "authentication_token" : User.currentUser().token! ]
                
            ]
            
        ] as [String: AnyObject]
        
        requestWithOptions(options, andCompletion: completion)
        
    }
    
    class func requestWithOptions(options: [String: AnyObject], andCompletion completion: ResponseBlock) {
        
        var url = NSURL(string: API_URL + (options["endpoint"] as String))
        
        var request = NSMutableURLRequest(URL: url!)
        
        request.HTTPMethod = options["method"] as String
        
        ///// BODY
        
        let bodyInfo = options["body"] as [String:AnyObject]
        
        let requestData = NSJSONSerialization.dataWithJSONObject(bodyInfo, options: NSJSONWritingOptions.allZeros, error: nil)
        
        let jsonString = NSString(data: requestData!, encoding: NSUTF8StringEncoding)

        let postLength = "\(jsonString!.length)"

        request.setValue(postLength, forHTTPHeaderField: "Content-Length")

        let postData = jsonString?.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.HTTPBody = postData
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            
            if error == nil {
                
                // do something with data
                
                let json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as [String:AnyObject]
                
                completion(responseInfo: json)
                
            } else {
                
                println(error)
                
            }
            
        }
        
        
    }
    
}

private let _currentUser = User()

class User {
    
    var token: String? {
        
        didSet {
            
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(token, forKey: "token")
            defaults.synchronize()
            
        }
        
    }
    
    init() {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        token = defaults.objectForKey("token") as? String
    
    }
    
    class func currentUser() -> User { return _currentUser }
    
    func register(username: String, email: String, password: String) {
        
        let options: [String:AnyObject] = [
            "endpoint" : "users",
            "method" : "POST",
            "body" : [
                
                "user" : [ "username" : username, "email" : email, "password" : password ]
            
            ]
        
        ]
        
        APIRequest.requestWithOptions(options, andCompletion: { (responseInfo) -> () in
            
            println(responseInfo)
            
            let dataInfo = responseInfo["data"] as [String:String]
            
            self.token = dataInfo["auth_token"]
            // do something here after request is done
            
        })
        
    }
    
    func login(email: String, password: String) {
        
        let options: [String:AnyObject] = [
            "endpoint" : "users/sign_in",
            "method" : "POST",
            "body" : [
                
                "user" : [ "email" : email, "password" : password ]
                
            ]
            
        ]
        
        APIRequest.requestWithOptions(options, andCompletion: { (responseInfo) -> () in
            
            println(responseInfo)
            
            let dataInfo = responseInfo["data"] as [String:String]
            
            self.token = dataInfo["auth_token"]
            // do something here after request is done
            
        })
        
    }
    
}






