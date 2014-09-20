//
//  ViewController.swift
//  Rails App
//
//  Created by Jo Albright on 9/2/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

import UIKit

let API = "http://ancient-taiga-9634.herokuapp.com/"

class ViewController: UIViewController {
    
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var contentField: UITextField!
    
//    {
//        content = "'gfdsgdfs gfdsfdsgfsd gfdsgfds'",
//        posted_at = "2014-09-02T14:24:08.567Z",
//        title = "'gdfsgsd gdfsgfdsg gdfsgdfs'",
//        user = "jo@theironyard.com"
//    }
    
    @IBAction func postNew(sender: AnyObject) {
        
        let newPostURL = API + "posts?post[title]='\(titleField.text)'&post[content]='\(contentField.text)'"
        
        let encodedString = newPostURL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        
        var request = NSMutableURLRequest(URL: NSURL(string: encodedString!))
        
        request.setValue("zxcasdqwe", forHTTPHeaderField: "AUTH_TOKEN")
        request.HTTPMethod = "POST"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            let info: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil)
            
            println(info)
            
        }
    }
    
    @IBAction func getMyPosts(sender: AnyObject) {
        
        let myPostsURL = API + "posts/mine"
        
        var request = NSMutableURLRequest(URL: NSURL(string: myPostsURL))
        
        request.setValue("zxcasdqwe", forHTTPHeaderField: "AUTH_TOKEN")
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            let posts = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSArray
            
            println(posts)
            
        }
    }
    
    @IBAction func getAllPosts(sender: AnyObject) {
        
        let allPostsURL = API + "posts"
        
        let request = NSURLRequest(URL: NSURL(string: allPostsURL))
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            let posts = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSArray
            
            println(posts)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

