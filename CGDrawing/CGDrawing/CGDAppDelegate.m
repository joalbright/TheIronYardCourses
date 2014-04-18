//
//  CGDAppDelegate.m
//  CGDrawing
//
//  Created by Jo Albright on 4/17/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "CGDAppDelegate.h"

#import "CGDrawing.h"

@implementation CGDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    UIViewController * viewController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    
    viewController.view = [[CGDrawing alloc] init];
    
    self.window.rootViewController = viewController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
