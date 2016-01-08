//
//  FourSquareRequest.swift
//  Maps
//
//  Created by Jo Albright on 2/2/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit
import CoreLocation

let API_URL = "https://api.foursquare.com/v2/"
let CLIENT_ID = "2MJ4R0XEU4WQ1YUPUUHTS5FJFZL3A1H4PR1Z2BPI1AHUEHOE"
let CLIENT_SECRET = "J1SLYGGM4YDU11HUXVA4H0ECU2YZFUDJ0UK2MST502ZGENZZ"

class FourSquareRequest: NSObject {
   
    class func requestVenuesWithLocation(location: CLLocation) -> [AnyObject] {
        
        
        let requestString = "\(API_URL)venues/search?client_id=\(CLIENT_ID)&client_secret=\(CLIENT_SECRET)&v=20130815&ll=\(location.coordinate.latitude),\(location.coordinate.longitude)"
        
//        println(requestString)
        
        if let url = NSURL(string: requestString) {
            
            let request = NSURLRequest(URL: url)
            
            if let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil) {
                
                if let returnInfo = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? [String:AnyObject] {
                    
                    let responseInfo = returnInfo["response"] as [String:AnyObject]
                    
                    let venues = responseInfo["venues"] as [[String:AnyObject]]
                    
                    return venues
                    
                }
                
                
                
            }
            
            
            
        }
        
        
        // TODO: add implementation to return venues
        
        return []
        
    }
    
}







