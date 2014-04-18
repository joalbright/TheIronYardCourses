//
//  BBAViewController.m
//  BrickBreaker
//
//  Created by Jo Albright on 4/17/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "BBAViewController.h"

#import "BBALevelController.h"

@interface BBAViewController () <BBALevelDelegate>

@end

@implementation BBAViewController
{
    BBALevelController * level;
    
    UIButton * startButton;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    startButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 200) / 2, (SCREEN_HEIGHT - 200) / 2, 200, 200)];
    startButton.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1.0];
    startButton.layer.cornerRadius = 100;
    startButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:50];
    
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton setTitle:@"START" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:startButton];
}

- (void)startGame
{
    level = [[BBALevelController alloc] initWithNibName:nil bundle:nil];
    level.delegate = self;
    
    level.view.frame = CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT - 40);
    [self.view addSubview:level.view];
    
    [startButton removeFromSuperview];
    [level resetLevel];
}

- (void)gameDone
{
    [level.view removeFromSuperview];
    [self.view addSubview:startButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden { return YES; }

@end
