//
//  ViewController.swift
//  MyWorld
//
//  Created by Jo Albright on 5/21/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var myMapView: MKMapView!
    
    var lManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        lManager.requestWhenInUseAuthorization()
        lManager.delegate = self
        
        myMapView.showsUserLocation = true
        myMapView.userTrackingMode = .Follow
        
        lManager.startUpdatingLocation()
        
    }
    
    func requestVenuesWithLocation(location: CLLocation, completion: (venues: [AnyObject]) -> ()) {
        
        let API_URL = "https://api.foursquare.com/v2/"
        let CLIENT_ID = "5MXUODIJJ0PWRB05NDV5EF51XSQ44YZZ32U2MIKXTKDK0SDL"
        let CLIENT_SECRET = "NNYQJYG4LQZ2WDRPRMOFL5PBKNC31BZ2WODYOPACPJ3J3U3L"
        
        let endpoint = API_URL + "venues/search?client_id=\(CLIENT_ID)&client_secret=\(CLIENT_SECRET)&ll=\(location.coordinate.latitude),\(location.coordinate.longitude)&v=20150101"
        
        println(endpoint)
        
        if let url = NSURL(string: endpoint) {
            
            let request = NSURLRequest(URL: url)
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) -> Void in
                
                // data is the information that is returned
                
                println(data)
                
                if let returnedInfo = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? [String:AnyObject] {
                    
                    println(returnedInfo)
                    
                    if let responseInfo = returnedInfo["response"] as? [String:AnyObject] {
                        
                        if let venuesInfo = responseInfo["venues"] as? [AnyObject] {
                            
                            completion(venues: venuesInfo)
                            
                        }
                        
                    }
                    
                    
                }
                
            })
            
        }
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        if let location = locations.first as? CLLocation {
            
            println("latitude \(location.coordinate.latitude) longitude \(location.coordinate.longitude)")
            
            requestVenuesWithLocation(location, completion: { (venues) -> () in
                
                println(venues)
                
                for venue in venues as! [[String:AnyObject]] {
                    
                    if let locationInfo = venue["location"] as? [String:AnyObject] {
                        
                        if let lat = locationInfo["lat"] as? Double, let lng = locationInfo["lng"] as? Double {
                            
                            let coordinate = CLLocationCoordinate2DMake(lat, lng)
                            
                            let annotation = MKPointAnnotation()
                            
                            annotation.title = venue["name"] as? String
                            
                            annotation.coordinate = coordinate
                            
                            self.myMapView.addAnnotation(annotation)
                            
                        }
                        
                    }
                    
                }
                
            })
            
            lManager.stopUpdatingLocation()
            
        }
        
    }
    
    
}



