//
//  NSAAppDelegate.m
//  Noisy
//
//  Created by Jo Albright on 6/5/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "NSAAppDelegate.h"

#import "NSAViewController.h"

@implementation NSAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.window.rootViewController = [[NSAViewController alloc] init];
    
//    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

@end
