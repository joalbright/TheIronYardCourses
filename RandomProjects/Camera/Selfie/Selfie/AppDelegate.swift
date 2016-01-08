//
//  AppDelegate.swift
//  Selfie
//
//  Created by Jo Albright on 10/26/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
//        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
//        [Parse setApplicationId:@"aFTTxxEQqzCB8nT5E6ykgqA6f9BZkCEk7TpD71Xj" clientKey:@"PnEILl81ywK1T7lABW3Vmoc6Wl8NvA6ySKJ1EARw"];
        
        Parse.setApplicationId("aFTTxxEQqzCB8nT5E6ykgqA6f9BZkCEk7TpD71Xj", clientKey: "PnEILl81ywK1T7lABW3Vmoc6Wl8NvA6ySKJ1EARw")
        
//        UINavigationController * nc;
        
        var nc: UINavigationController?
        
//        if ([PFUser currentUser] != nil) {
        
        if PFUser.currentUser() != nil {
            
            // we are logged in
//            UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
//            nc = [mainStoryboard instantiateInitialViewController];
            
            if let mainNC = mainStoryboard.instantiateInitialViewController() as? UINavigationController {
                
                nc = mainNC
                
            }

        } else {
            
            // not logged in
//            UIStoryboard * userStoryboard = [UIStoryboard storyboardWithName:@"User" bundle:nil];
            
            let userStoryboard = UIStoryboard(name: "User", bundle: nil)
            
//            nc = [userStoryboard instantiateInitialViewController];

            if let userNC = userStoryboard.instantiateInitialViewController() as? UINavigationController {
                
                nc = userNC
                
            }
            
        }
        
//        self.window.rootViewController = nc;
      
        window?.rootViewController = nc
        
//        [self.window makeKeyAndVisible];
        
        window?.makeKeyAndVisible()
        
        return true
    }

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

