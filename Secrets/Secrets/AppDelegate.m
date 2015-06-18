//
//  AppDelegate.m
//  Secrets
//
//  Created by Jo Albright on 6/15/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

#import "AppDelegate.h"

#import <Parse/Parse.h>
#import <Bolts/Bolts.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    [Parse setApplicationId:@"H6bP6K8eMKvv7boF0OnjxTbEIhcdjB1fPyKkCpys" clientKey:@"7iyOvKoxnV2jKYfcu30DkWegnR4tTGseXR8fxp0D"];
    
//    [PFUser enableAutomaticUser];
    
//    PFUser * user = [PFUser user];
//    user.username = @"jo";
//    user.password = @"password";
//    [user signUpInBackground];
    
    // this was long running
//    [PFUser logInWithUsername:@"jo" password:@"password"];
    
    [PFUser logInWithUsernameInBackground:@"jo" password:@"password"];
    
    // Register for Push Notifications
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound);
    UIUserNotificationSettings * settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes categories:nil];
    [application registerUserNotificationSettings:settings];
    [application registerForRemoteNotifications];
    
    PFInstallation * currentInstallation = [PFInstallation currentInstallation];
    currentInstallation[@"user"] = [PFUser currentUser];
    [currentInstallation saveInBackground];
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Store the deviceToken in the current installation and save it to Parse.
    
    NSLog(@"deviceToken %@", deviceToken);
    
    PFInstallation * currentInstallation = [PFInstallation currentInstallation];

    // users may have multiple devices
//    [PFUser currentUser][@"device"] = currentInstallation;
//    [[PFUser currentUser] saveInBackground];
    
    currentInstallation[@"user"] = [PFUser currentUser];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
