//
//  DLAAppDelegate.m
//  DrawLinesApp
//
//  Created by Jo Albright on 4/15/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "DLAAppDelegate.h"

#import "DLAViewController.h"

@implementation DLAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    
    self.window.rootViewController = [[DLAViewController alloc] initWithNibName:nil bundle:nil];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
