//
//  ViewController.swift
//  BeaconHunt
//
//  Created by Jo Albright on 11/10/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import UIKit

let estimoteGreen = UIColor(red:0.69, green:0.82, blue:0.7, alpha:1)
let estimoteBlue = UIColor(red:0.69, green:0.83, blue:0.9, alpha:1)
let estimotePurple = UIColor(red:0.31, green:0.28, blue:0.52, alpha:1)

class ViewController: UIViewController, ESTBeaconManagerDelegate {
    
    @IBOutlet weak var beaconImageView: UIImageView!
    
    @IBOutlet weak var beaconAccuracyView: AccuracyView!
    
    @IBOutlet weak var beaconProximityLabel: UILabel!
    
    enum BeaconColor: Int {
        
        case Green = 100, Blue = 200, Purple = 300
        
        func color() -> UIColor {
            
            switch self {
                
            case .Green: return estimoteGreen
            case .Blue: return estimoteBlue
            case .Purple: return estimotePurple
                
            }
            
        }
        
        func image() -> UIImage? {
            
            switch self {
                
            case .Green: return UIImage(named: "BeaconGreen")
            case .Blue: return UIImage(named: "BeaconBlue")
            case .Purple: return UIImage(named: "BeaconPurple")
                
            }
            
        }
        
    }

    let beaconManager = ESTBeaconManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beaconManager.delegate = self
        
        beaconManager.requestAlwaysAuthorization()
        
        if let uuid = NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D") {
            
            let region = CLBeaconRegion(proximityUUID: uuid, identifier: "beacons")

            beaconManager.startRangingBeaconsInRegion(region)
            
        }
        
    }
    
    func beaconManager(manager: AnyObject, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        
        guard let beacon = beacons.first else { return }
        
        print(beacon.major,beacon.minor,beacon.accuracy,beacon.proximity.rawValue)
        
        let color = BeaconColor(rawValue: Int(beacon.major))?.color() ?? UIColor.lightGrayColor()
        
        beaconProximityLabel.textColor = color
        beaconAccuracyView.beaconColor = color
        
        let image = BeaconColor(rawValue: Int(beacon.major))?.image() ?? UIImage(named: "BeaconGrey")
        
        beaconImageView.image = image
        
    }

}

