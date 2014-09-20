//
//  ViewController.swift
//  The Swift List
//
//  Created by Jo Albright on 8/22/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let tabBarC = UITabBarController()

    var niceArray = ["Helpful Robots","Some Humans"]
    var naughtyArray = ["Invading Aliens","Killer Robots","Jaws"]
    
    let listNameField = UITextField(frame: CGRectMake(10, 10, UIScreen.mainScreen().bounds.size.width - 20, 40))
    let listOption = UISegmentedControl(frame: CGRectMake(10, 60, UIScreen.mainScreen().bounds.size.width - 20, 40))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.addSubview(tabBarC.view)
        self.addChildViewController(tabBarC)
        
        let niceList = UITableViewController()
        niceList.title = "Nice"
        niceList.tableView.dataSource = self
        niceList.tableView.delegate = self
//        niceList.tableView.tag = 0
        niceList.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        niceList.tabBarItem.image = UIImage(named: "nice")
        
        let naughtyList = UITableViewController()
        naughtyList.title = "Naughty"
        naughtyList.tableView.dataSource = self
        naughtyList.tableView.delegate = self
        naughtyList.tableView.tag = 1
        naughtyList.tabBarItem.image = UIImage(named: "naughty")
        naughtyList.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        
        let addToList = UIViewController()
        addToList.title = "Add To List"
        
        listNameField.layer.cornerRadius = 10
        listNameField.backgroundColor = UIColor.lightGrayColor()
        
        addToList.view.addSubview(listNameField)
        
        listOption.tintColor = UIColor.lightGrayColor()
        listOption.insertSegmentWithTitle("Nice", atIndex: 0, animated: true)
        listOption.insertSegmentWithTitle("Naughty", atIndex: 1, animated: true)
        
        addToList.view.addSubview(listOption)
        
        let addButton = UIButton(frame: CGRectMake(10, 110, UIScreen.mainScreen().bounds.size.width - 20, 40))
        addButton.backgroundColor = addButton.tintColor
        addButton.tintColor = UIColor.whiteColor()
        addButton.layer.cornerRadius = 10
        addButton.setTitle("Add New Item", forState: .Normal)
        addButton.addTarget(self, action: Selector("addNewItem"), forControlEvents: .TouchUpInside)
        
        addToList.view.addSubview(addButton)
        
        tabBarC.viewControllers = [niceList,naughtyList,addToList]
    }
    
    func addNewItem() {
        
        
//        var itemArray = (Bool(listOption.selectedSegmentIndex)) ? naughtyArray : niceArray
        
//        itemArray += [listNameField.text]
        
        switch listOption.selectedSegmentIndex {
            
        case 0:
        
            niceArray += [listNameField.text]
            
        case 1:
            
            naughtyArray.append(listNameField.text)
            
        default :
            
            print("default")
            
        }
        
        listNameField.text = ""
        listNameField.resignFirstResponder()
        
        (tabBarC.viewControllers[listOption.selectedSegmentIndex] as UITableViewController).tableView.reloadData()
        
//        println(itemArray)
        println(naughtyArray)
        println(niceArray)
    }

    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        
        return (Bool(tableView.tag)) ? naughtyArray.count : niceArray.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        let itemArray = (Bool(tableView.tag)) ? naughtyArray : niceArray
        
        cell.textLabel.text = itemArray[indexPath.row]
        
        return cell
    }
}

