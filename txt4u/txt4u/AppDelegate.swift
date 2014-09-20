//
//  AppDelegate.swift
//  txt4u
//
//  Created by Jo Albright on 9/10/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Parse.setApplicationId("Xuqy93jZKqYMYprWT5CRExzvbPlmKpLK6vMqRpIS", clientKey: "S2NQPyWSx8bQKa94IwxsEqcyuLu8TYfTl2DfljgK")
        
        PFUser.enableAutomaticUser()
        
        var installation = PFInstallation.currentInstallation()
        installation["user"] = PFUser.currentUser()
        installation.saveInBackground()
        
        var types = UIUserNotificationType.Sound | UIUserNotificationType.Badge | UIUserNotificationType.Alert
        
        var notificationSettings = UIUserNotificationSettings(forTypes: types, categories: nil)
        
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        
        UIApplication.sharedApplication().registerForRemoteNotifications()
        
//        UIApplication.sharedApplication().unregisterForRemoteNotifications()
        
        
        // Override point for customization after application launch.
        return true
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
//        println("register")
        
        var currentInstallation = PFInstallation.currentInstallation()
        currentInstallation.setDeviceTokenFromData(deviceToken)
        currentInstallation.saveInBackground()
        
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        
//        println(userInfo)
        
        var notification = userInfo["aps"] as NSDictionary
//        println(notification)
        var alert = notification["alert"] as String
//        println(alert)
        var sender = userInfo["sender"] as NSDictionary
//        println(sender)
        var senderName = sender["objectId"] as String
//        println(senderName)
        
//        UIApplication.sharedApplication().applicationIconBadgeNumber++
        // badge goes up here
        
        println(UIApplication.sharedApplication().applicationIconBadgeNumber)
        
        // when messageVC shows unread messages change badge count
        
        if UIApplication.sharedApplication().applicationState == UIApplicationState.Background {
            
            var localNotification = UILocalNotification()
            localNotification.alertBody = "\(senderName) : " + alert
            localNotification.alertAction = "Reply"
            
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
            
        } else {
            
            var nc = NSNotificationCenter.defaultCenter()
            nc.postNotificationName("newMessage", object: nil, userInfo: userInfo)
            
        }
        
//        println(userInfo)
        
    }
    
//    - (void)application:(UIApplication *)application
//    didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
//    {
//    // Store the deviceToken in the current Installation and save it to Parse.
//    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
//    [currentInstallation setDeviceTokenFromData:deviceToken];
//    [currentInstallation saveInBackground];
//    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

