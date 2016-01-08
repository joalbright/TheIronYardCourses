//
//  ViewController.swift
//  Re.Action
//
//  Created by Jo Albright on 9/18/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

import UIKit

import GameKit
import StoreKit

let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height

class ViewController: UIViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    var timer: NSTimer?
    let timerBar = UIView()
    
    let buttons = [UIButton(),UIButton(),UIButton()]
    
    let scoreLabel = UILabel()
    
    var currentScore = 0
    var buttonToTap = 0
    
    var player = GKLocalPlayer.localPlayer()
    var allLeaderboards: [String:GKLeaderboard] = Dictionary()
    
    var startReactionTime: NSDate!
    var endReactionTime: NSDate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clearColor()
        
        // first color
        var topColor = UIColor(red: 0.910, green: 0.976, blue: 0.333, alpha: 1.0)
        // second color
        var bottomColor = UIColor(red: 0.973, green: 0.204, blue: 0.333, alpha: 1.0)
        // array of colors in gradient
        var gradientColors: [AnyObject] = [topColor.CGColor, bottomColor.CGColor]
        // array of locations for colors in gradient
        var gradientLocations = [0.0,1.0]
        // gradient layer
        var gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.frame
        
        gradientLayer.startPoint = CGPointMake(0.6, -0.1)
        gradientLayer.endPoint = CGPointMake(0.4, 1.1)
        
        // add colors to gradient layer
        gradientLayer.colors = gradientColors
        // add locations to gradient layer
        gradientLayer.locations = gradientLocations
        
        // add gradient to view layer as background
        self.view.layer.addSublayer(gradientLayer)
        
        for i in 0..<buttons.count {
            
            var button = buttons[i]
            
            var size: CGFloat = 100.0
            
            var x = (SCREEN_WIDTH / 2.0) - (size / 2.0)
            var y = (SCREEN_HEIGHT / 2.0) - (size / 2.0) + (CGFloat(i - 1) * (size + 20))
            
            button.alpha = 0.6
            button.frame = CGRectMake(x, y, size, size)
            button.layer.cornerRadius = size / 2.0
            button.backgroundColor = UIColor.whiteColor()
            button.tag = i
            
            button.addTarget(self, action: Selector("buttonTapped:"), forControlEvents: .TouchUpInside)
            
            self.view.addSubview(button)
            
        }
        
        timerBar.backgroundColor = UIColor.whiteColor()
        timerBar.frame = CGRectMake(0, 0, 0, 6)
        self.view.addSubview(timerBar)
        
        var time = dispatch_time(DISPATCH_TIME_NOW, Int64(3.0 * Double(NSEC_PER_SEC)))
        
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            
            self.runLevel()
            
        }
        
        var nc = NSNotificationCenter.defaultCenter()
        
        nc.addObserver(self, selector: Selector("authChanged"), name: GKPlayerAuthenticationDidChangeNotificationName, object: nil)
        
        
        if player.authenticated == false {
            
            player.authenticateHandler = { (viewController, error) -> Void in
             
                if viewController != nil {
                    self.presentViewController(viewController, animated: true, completion: nil)
                }
                
            }
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        
//        for transaction in
//            SKPaymentQueue.defaultQueue().transactions as [SKPaymentTransaction] {
//                
//                SKPaymentQueue.defaultQueue().transactions
//        }
        
        var productRequest = SKProductsRequest(productIdentifiers: NSSet(array: ["test"]))
        
        productRequest.delegate = self
        productRequest.start()
        
        var button = UIButton(frame: CGRectMake(10, SCREEN_HEIGHT - 50, SCREEN_WIDTH - 20, 40))
        button.setTitle("Purchase", forState: .Normal)
        button.addTarget(self, action: Selector("purchase"), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(button)
    }
    
    var products: [SKProduct] = []
    
    func productsRequest(request: SKProductsRequest!, didReceiveResponse response: SKProductsResponse!) {
        
        for product in response.products as [SKProduct] {
            
            println(product.localizedTitle)
            println(product.price)
            
        }
        
        products = response.products as [SKProduct]
        
    }
    
    func purchase() {
        
//        32e9396f8dc24c20b37c9210ba455a96
//        println(SKPaymentQueue.canMakePayments())
        
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
        println(SKPaymentQueue.defaultQueue().transactions)

        var payment = SKPayment(product: products[0])
        SKPaymentQueue.defaultQueue().addPayment(payment)
        
        
//        for product in products {
//            
//            var payment = SKPayment(product: product)
//            
//            SKPaymentQueue.defaultQueue().addPayment(payment)
//            
//        }
        
    }
    
    func paymentQueue(queue: SKPaymentQueue!, updatedTransactions transactions: [AnyObject]!) {
        
        for transaction in transactions as [SKPaymentTransaction] {
            
            switch (transaction.transactionState) {
                
            case SKPaymentTransactionState.Purchasing :
                
                println("Purchasing")
                
            case SKPaymentTransactionState.Purchased :
                
                println("Purchased");
                
                SKPaymentQueue.defaultQueue().finishTransaction(transaction)
                
            case SKPaymentTransactionState.Restored :
                
                println("Restored")
                SKPaymentQueue.defaultQueue().finishTransaction(transaction)
                
            case SKPaymentTransactionState.Failed :
                
                println("Failed")

            default:
                
                println("Default")
            }
            
        }
        
    }
    
    func resetTimerWithSpeed(speed: Double) {
        
        if timer != nil { timer!.invalidate() }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(speed, target: self, selector: Selector("timerDone"), userInfo: nil, repeats: false)
        
        
        timerBar.layer.removeAllAnimations()
        timerBar.frame.size.width = SCREEN_WIDTH

        
        UIView.animateWithDuration(speed, delay: 0, options: .CurveLinear, animations: { () -> Void in
            
            self.timerBar.frame.size.width = 0
            
            }) { (succeeded) -> Void in
            
                
        }
        
    }
    
    func timerDone() {
        
        println("Game Over")
        
    }
    
    
    func buttonTapped(button: UIButton) {
        
//        println(button.tag)
        
        if buttonToTap == button.tag {
            
            endReactionTime = NSDate()
            
            let reactionTime = endReactionTime.timeIntervalSinceDate(startReactionTime)
            
            submitReactionTime(reactionTime)
            
            currentScore++
            checkAchievement()
            runLevel()
            
        } else {
            
            submitScore()
            currentScore = 0
            println("Fail")
            
            var time = dispatch_time(DISPATCH_TIME_NOW, Int64(3.0 * Double(NSEC_PER_SEC)))
            
            dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
                
                self.runLevel()
                
            }
            
        }
        
    }
    
    func runLevel() {
        
        startReactionTime = NSDate()
        
        buttonToTap = Int(arc4random_uniform(3))
        
        var button = buttons[buttonToTap]
        
        button.alpha = 1.0
        
//        UIView.animateWithDuration(1.0, animations: { () -> Void in
//            
//            button.alpha = 0.6
//            
//        })
        
        UIView.animateWithDuration(1.0, delay: 0, options: .AllowUserInteraction, animations: { () -> Void in
            
            button.alpha = 0.6
            
            }) { (succeeded: Bool) -> Void in
                
                
        }
        
        resetTimerWithSpeed(10)
    }
    
    func authChanged() {
        
        if player.authenticated == false { return }
        
        GKLeaderboard.loadLeaderboardsWithCompletionHandler { (leaderboards, error) -> Void in
            
            for leaderboard in leaderboards as [GKLeaderboard] {
                
                self.allLeaderboards[leaderboard.identifier] = leaderboard
                
            }
            
        }
        
    }
    
    func submitScore() {
        
        var scoreReporter = GKScore(leaderboardIdentifier: "total_taps")
        
        scoreReporter.value = Int64(currentScore)
        scoreReporter.context = 0
        
        GKScore.reportScores([scoreReporter], withCompletionHandler: { (error) -> Void in
            
            println("score reported")
            
        })
        
    }
    
    func submitReactionTime(time: NSTimeInterval) {
        
        var scoreReporter = GKScore(leaderboardIdentifier: "reaction_time")
        
        scoreReporter.value = Int64(time * 100.0)
        scoreReporter.context = 0
        
        GKScore.reportScores([scoreReporter], withCompletionHandler: { (error) -> Void in
            
            println("reaction time reported")
            
        })
        
    }
    
    func checkAchievement() {
        
        if currentScore >= 5 {
            
            var score50 = GKAchievement(identifier: "score_50")
            
            score50.percentComplete = 100.0
            score50.showsCompletionBanner = true
            
            GKAchievement.reportAchievements([score50], withCompletionHandler: { (error) -> Void in
                
                println("achievement sent")
                
            })
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

