//
//  ViewController.swift
//  SquareToken
//
//  Created by Jo Albright on 9/30/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

import UIKit

// https://foursquare.com/oauth2/authenticate?client_id=2MJ4R0XEU4WQ1YUPUUHTS5FJFZL3A1H4PR1Z2BPI1AHUEHOE&response_type=token&redirect_uri=http://coolapp.com

// http://coolapp.com/#access_token=TMXL0ZS10UCKNHNH2X2B5PZDTI5BBCWSXOCX0VA14IHXKNSB

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UIApplication.sharedApplication().openURL(NSURL(string: "https://foursquare.com/oauth2/authenticate?client_id=2MJ4R0XEU4WQ1YUPUUHTS5FJFZL3A1H4PR1Z2BPI1AHUEHOE&response_type=token&redirect_uri=squaretoken://squaretoken.com"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

