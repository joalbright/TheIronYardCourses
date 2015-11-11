//
//  ViewController.swift
//  Clock
//
//  Created by Jo Albright on 11/10/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentTimeLabel: UILabel!
    
    @IBOutlet weak var countDownTextField: UITextField!
    
    @IBOutlet weak var countDownLabel: UILabel!
    
    @IBAction func pressedStart(sender: AnyObject) {
    
        guard countDownTimer == nil else { return }
        
        guard let secondsText = countDownTextField.text else { return }
        
        countDownLeft = Double(secondsText) ?? 0
        
        if countDownLeft > 0 {
            
            countDownLeft++
            updateCountDown()
            
            countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateCountDown", userInfo: nil, repeats: true)
            
            countDownTextField.text = ""
            countDownTextField.resignFirstResponder()
            
        }
        
    }
    
    @IBAction func pressedClear(sender: AnyObject) {
        
        countDownTimer?.invalidate()
        countDownTimer = nil
        
        countDownLabel.text = "00:00:00"
        
    }
    
    var currentTimeTimer: NSTimer?
    
    var countDownTimer: NSTimer?
    
    var countDownLeft: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateCurrentTime()
        
        currentTimeTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateCurrentTime", userInfo: nil, repeats: true)
        
    }
    
    func updateCurrentTime() {
        
        // get current date/time
        let date = NSDate()
        
        // update label with format hh:mm:ss
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        currentTimeLabel.text = formatter.stringFromDate(date)
        
    }
    
    func updateCountDown() {
        
        // decrementing a property
        countDownLeft--
        
        let hours = Int(floor(countDownLeft / 3600))
        let minutes = Int(floor((countDownLeft % 3600) / 60))
        let seconds = Int(countDownLeft % 60)
        
        let hourString = hours < 10 ? "0\(hours)" : "\(hours)"
        let minuteString = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        let secondString = seconds < 10 ? "0\(seconds)" : "\(seconds)"
        
        // update label with format hh:mm:ss
        countDownLabel.text = "\(hourString):\(minuteString):\(secondString)"
        
        if countDownLeft <= 0 {
            
            countDownTimer?.invalidate()
            countDownTimer = nil
            
        }
        
    }
    
}

