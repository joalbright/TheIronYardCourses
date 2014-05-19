//
//  PNAAppDelegate.m
//  PixelNoise
//
//  Created by Jo Albright on 5/4/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "PNAAppDelegate.h"
#import "PNAViewController.h"

#import "PNAPixelWorld2Controller.h"

@implementation PNAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.window.rootViewController = [[PNAPixelWorld2Controller alloc] initWithNibName:nil bundle:nil];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
