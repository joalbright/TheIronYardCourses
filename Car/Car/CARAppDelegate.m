//
//  CARAppDelegate.m
//  Car
//
//  Created by Jo Albright on 4/1/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "CARAppDelegate.h"

#import "CARRootViewController.h"

@implementation CARAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.rootViewController = [[CARRootViewController alloc] init];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
