//
//  ViewController.swift
//  Rails
//
//  Created by Jo Albright on 8/29/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var post_url = NSURL(string: "http://ancient-taiga-9634.herokuapp.com/posts?post[title]=test2&post[content]=hello2")
        var post_request = NSMutableURLRequest(URL: post_url)
        
        post_request.HTTPMethod = "POST"
        post_request.setValue("zxcasdqwe", forHTTPHeaderField: "AUTH_TOKEN")
        
        NSURLConnection.sendAsynchronousRequest(post_request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            var info = NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments, error: nil)
            
            println(info)
            
        }
        
        var url = NSURL(string: "http://ancient-taiga-9634.herokuapp.com/posts/mine")
        var request = NSMutableURLRequest(URL: url)
        
        request.setValue("zxcasdqwe", forHTTPHeaderField: "AUTH_TOKEN")
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            var info = NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments, error: nil)
            
            println(info)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

