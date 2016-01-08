//
//  AMAViewController.m
//  AdMonkey
//
//  Created by Jo Albright on 6/10/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "AMAViewController.h"

#import <iAd/iAd.h>

@interface AMAViewController ()

@end

@implementation AMAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.canDisplayBannerAds = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
