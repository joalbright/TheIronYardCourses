//
//  BBAAppDelegate.m
//  BrickBreaker
//
//  Created by Jo Albright on 4/17/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "BBAAppDelegate.h"

#import "BBAViewController.h"

@implementation BBAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    
    self.window.rootViewController = [[BBAViewController alloc] initWithNibName:nil bundle:nil];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
