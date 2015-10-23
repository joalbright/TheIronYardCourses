//
//  ProfileViewController.swift
//  Venues
//
//  Created by Jo Albright on 10/7/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    
    @IBAction func connectToFoursquare(sender: AnyObject) {
        
        let urlString = "https://foursquare.com/oauth2/authenticate?client_id=" + CLIENT_ID + "&response_type=code&redirect_uri=http://venues.jo2.co"
        
        if let url = NSURL(string: urlString) {
            
            
            
            if let webVC = storyboard?.instantiateViewControllerWithIdentifier("WebVC") as? WebViewController {
            
                webVC.url = url
                presentViewController(webVC, animated: true, completion: nil)
                
            }
            
        }
        
    }
    
    @IBOutlet weak var connectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
