//
//  ViewController.swift
//  Directions
//
//  Created by Jo Albright on 3/17/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var myMapView: MKMapView!
    
    var lManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        lManager.requestWhenInUseAuthorization()
        
        myMapView.showsUserLocation = true
        
        let gC = CLGeocoder()
        
        gC.geocodeAddressString("30303", completionHandler: { (placemarks, error) -> Void in
            
            if let placemark = placemarks.last as? CLPlacemark {
                
                
                let mP = MKPlacemark(placemark: placemark)
                
                let mapItem: MKMapItem = MKMapItem(placemark: mP)
                
//                mapItem.openInMapsWithLaunchOptions(nil)
                
                let options = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeWalking]
                
                let currentMapItem: MKMapItem = MKMapItem.mapItemForCurrentLocation()
                
                MKMapItem.openMapsWithItems([currentMapItem,mapItem], launchOptions: options)
                
            }
            
        })
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

