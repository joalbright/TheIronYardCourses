//
//  ViewController.swift
//  Favorites
//
//  Created by Jo Albright on 5/28/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var myFavorites: [PFObject] = []
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    @IBOutlet weak var favoriteTextField: UITextField!
    
    @IBAction func addFavorite(sender: AnyObject) {
        
        
        let newFavorite = PFObject(className: "Favorites")
        
        newFavorite["name"] = favoriteTextField.text
        newFavorite["user"] = PFUser.currentUser()
        
        newFavorite.saveInBackground()
        
        favoriteTextField.text = ""
        
        myFavorites.insert(newFavorite, atIndex: 0)
//        myFavorites.append(newFavorite)
        favoritesTableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        
        let query = PFQuery(className: "Favorites")
        
        query.orderByDescending("createdAt")
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            self.myFavorites = objects as! [PFObject]
            self.favoritesTableView.reloadData()
            
        }
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myFavorites.count
        
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("favoriteCell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = myFavorites[indexPath.row]["name"] as? String
        
        return cell
        
    }

}

