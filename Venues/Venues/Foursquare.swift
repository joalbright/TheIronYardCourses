//
//  Foursquare.swift
//  Venues
//
//  Created by Jo Albright on 10/6/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import UIKit

typealias Dictionary = [String:AnyObject]

import CoreLocation

private let API_URL = "https://api.foursquare.com/v2/"

private let _singleton = Foursquare()

class Foursquare: NSObject {

    class func session() -> Foursquare {
        
        return _singleton
        
    }
    
    var venues: [Dictionary] = []
    
    func getVenuesWithLocation(location: CLLocation, completion: () -> ()) {
        
        let urlString = API_URL + "venues/search?v=20130815&client_id=" + CLIENT_ID + "&client_secret=" + CLIENT_SECRET + "&ll=\(location.coordinate.latitude),\(location.coordinate.longitude)"
        
        if let url = NSURL(string: urlString) {
            
            let request = NSMutableURLRequest(URL: url)
            
            request.HTTPMethod = "GET"
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                
                if let d = data {
                    
                    if let resultInfo = try? NSJSONSerialization.JSONObjectWithData(d, options: NSJSONReadingOptions.MutableContainers) as? Dictionary
                    {
                        
                        if let responseInfo = resultInfo?["response"] as? Dictionary {
                            
                            self.venues = responseInfo["venues"] as? [Dictionary] ?? []
                            
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                
                                completion()
                                
                            })
                            
//                            print(self.venues)
                            
                        }
                        
                    }
                    
                }
                
            })
            
            task.resume()
            
        }
        
    }
    
}

