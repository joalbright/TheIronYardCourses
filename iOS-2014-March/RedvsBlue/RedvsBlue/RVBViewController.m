//
//  RVBViewController.m
//  RedvsBlue
//
//  Created by Jo Albright on 5/7/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "RVBViewController.h"

#import "RVBRedViewController.h"
#import "RVBBlueViewController.h"

#import "RVBData.h"

@interface RVBViewController () <RVBColorViewDelegate>

@end

@implementation RVBViewController
{
    RVBBlueViewController * blueVC;
    RVBRedViewController * redVC;
    
    UILabel * redScoreLabel;
    UILabel * blueScoreLabel;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [RVBData mainData].redScore = 0;
        [RVBData mainData].blueScore = 0;
        
        redVC = [[RVBRedViewController alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT / 2.0, SCREEN_WIDTH, SCREEN_HEIGHT / 2.0) andColor:[UIColor redColor]];
        redVC.delegate = self;
        
        blueVC = [[RVBBlueViewController alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 2.0) andColor:[UIColor blueColor]];
        blueVC.delegate = self;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view addSubview:redVC.view];
    [self.view addSubview:blueVC.view];
    
    
    redScoreLabel = [[UILabel alloc] initWithFrame:redVC.view.frame];
    redScoreLabel.textColor = [UIColor whiteColor];
    redScoreLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:100];
    redScoreLabel.textAlignment = NSTextAlignmentCenter;
    
    blueScoreLabel = [[UILabel alloc] initWithFrame:blueVC.view.frame];
    blueScoreLabel.textColor = [UIColor whiteColor];
    blueScoreLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:100];
    blueScoreLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:redScoreLabel];
    [self.view addSubview:blueScoreLabel];
    
    [self updateScore];
}

- (void)updateScore
{
    redScoreLabel.text = [@([RVBData mainData].redScore) stringValue];
    blueScoreLabel.text = [@([RVBData mainData].blueScore) stringValue];
}

@end
