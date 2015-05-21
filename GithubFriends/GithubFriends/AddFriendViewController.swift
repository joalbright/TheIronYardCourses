//
//  AddFriendViewController.swift
//  GithubFriends
//
//  Created by Jo Albright on 5/13/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

class AddFriendViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
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
