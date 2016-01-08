//
//  MapViewController.swift
//  Venues
//
//  Created by Jo Albright on 10/6/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var myMapView: MKMapView!
    
    let lManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lManager.delegate = self
        
        lManager.requestWhenInUseAuthorization()
        
        lManager.requestLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            
            print(location)
            
            // JO EXPLAIN
            
            Foursquare.session().getVenuesWithLocation(location) {
                
                // add annotations to map view
                
                for venue in Foursquare.session().venues {
                    
                    // use venue info to create annotation
                    
                    if let locationInfo = venue["location"] as? Dictionary {
                        
                        let lat = locationInfo["lat"] as? Double ?? 0
                        let lng = locationInfo["lng"] as? Double ?? 0
                        
                        let coord = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                        let title = venue["name"] as? String
                        
                        let annotation = MKPointAnnotation()
                        
                        annotation.coordinate = coord
                        annotation.title = title
                        
                        self.myMapView.addAnnotation(annotation)
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
        print(error)
        
    }
    

}
