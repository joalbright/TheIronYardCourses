//
//  ViewController.swift
//  Maps
//
//  Created by Jo Albright on 2/2/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//


// Homework

// - make the map view show your current location (not as an annotation, but as the blue dot)
// - make the "annotation view" show using "title" on an annotation (make the title be the name of the venue)
// - make the mapview zoom to the annotations (maybe look for a way to make a region based on the annotations)
// - change the pin color

import UIKit
import MapKit
import CoreLocation

var onceToken: dispatch_once_t = 0

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var lManager = CLLocationManager()
    var mapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.frame = view.frame
        view.addSubview(mapView)
        
        lManager.requestWhenInUseAuthorization()
        
        lManager.delegate = self
        
        lManager.desiredAccuracy = kCLLocationAccuracyBest
        lManager.distanceFilter = kCLDistanceFilterNone

        lManager.startUpdatingLocation()
        
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
 
        dispatch_once(&onceToken) { () -> Void in
            
            println(locations.last)
            
            if let location = locations.last as? CLLocation {
                
                let span = MKCoordinateSpanMake(0.1, 0.1)
                let region = MKCoordinateRegion(center: location.coordinate, span: span)
                
                self.mapView.setRegion(region, animated: true)
                
                let venues = FourSquareRequest.requestVenuesWithLocation(location)
                
                println(venues)
                
                self.createAnnotationsWithVenues(venues)
                
                // request to foursquare for venues with location
                
            }
            
        }
        
        lManager.stopUpdatingLocation()
        
    }
    
    func createAnnotationsWithVenues(venues: [AnyObject]) {
        
        for venue in venues as [[String:AnyObject]] {
         
            let locationInfo = venue["location"] as [String:AnyObject]
            
            let lat = locationInfo["lat"] as CLLocationDegrees
            let lng = locationInfo["lng"] as CLLocationDegrees
            
            let coordinate = CLLocationCoordinate2DMake(lat, lng)
            
            let annotation = MKPointAnnotation()
            annotation.setCoordinate(coordinate)
            
            mapView.addAnnotation(annotation)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

