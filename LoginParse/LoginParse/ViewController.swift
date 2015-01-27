//
//  ViewController.swift
//  LoginParse
//
//  Created by Jo Albright on 1/27/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func loginUser(sender: AnyObject) {
        
        var fieldValues: [String] = [usernameField.text,emailField.text,passwordField.text]
        
        if find(fieldValues, "") != nil {
            
            // all fields are not filled in
            var alertViewController = UIAlertController(title: "Submission Error", message: "All fields need to be filled in.", preferredStyle: UIAlertControllerStyle.Alert)
            
//            UIAlertAction * defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
//            handler:^(UIAlertAction * action) {}];
            
            var defaultAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            
            alertViewController.addAction(defaultAction)
            
            presentViewController(alertViewController, animated: true, completion: nil)
            
        } else {
            
            // all fields are filled in
            
            println("all fields are good and login")
            
            var userQuery = PFUser.query()
            
            userQuery.whereKey("username", equalTo: usernameField.text)
            
            userQuery.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
            
                if objects.count > 0 {
                    
                    self.login()
                    
                } else {
                    
                    self.signUp()
                    
                }
                
            })
            
            
//            signUp()
            
            
        }
        
        
    }
    
    func login() {
        
        PFUser.logInWithUsernameInBackground(usernameField.text, password:passwordField.text) {
            (user: PFUser!, error: NSError!) -> Void in
            
            if user != nil {
                
                println("logged in as \(user)")
                // Do stuff after successful login.
            } else {
                // The login failed. Check error to see why.
            }
            
        }
        
    }
    
    func signUp() {
        
        var user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        user.email = emailField.text
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            
            if error == nil {
                
                println(user)
                
                self.usernameField.text = ""
                self.passwordField.text = ""
                self.emailField.text = ""
                
                // Hooray! Let them use the app now.
                
            } else {
                
                let errorString = error.userInfo?["error"] as NSString
                // Show the errorString somewhere and let the user try again.
                
            }
            
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

