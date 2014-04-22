//
//  BBAViewController.m
//  BrickBreaker
//
//  Created by Jo Albright on 4/17/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "BBAViewController.h"

#import "BBALevelController.h"
#import "BBAHeader.h"
#import "BBAStats.h"

@interface BBAViewController () <BBALevelDelegate>

@end

@implementation BBAViewController
{
    BBALevelController * levelController;
    BBAHeader * header;
    BBAStats * stats;
    
    UIButton * startButton;
    UIButton * nextButton;
    
    int lives;
    int topScore;
    int level;
    
    BOOL newHighScore;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        topScore = 0;
        level = 0;
        
        newHighScore = NO;
        
        self.view.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1.0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ////////////////////
    
    // load default value
    
    startButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 200) / 2, (SCREEN_HEIGHT - 200) / 2 + 20, 200, 200)];
    startButton.backgroundColor = DARK_GREY;
    startButton.layer.cornerRadius = 100;
    startButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:80];
    startButton.alpha = 0.0;
    
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton setTitle:@"1" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:startButton];
    
    [UIView animateWithDuration:0.3 animations:^{
        startButton.alpha = 1.0;
    }];
    
    ////////////////////
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    topScore = [[userDefaults objectForKey:@"topScore"] intValue];
    
    
    header = [[BBAHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    header.topScore = topScore;
    [header showStart];
    [self.view addSubview:header];
    
    ////////////////////
    
    nextButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 260), (SCREEN_HEIGHT - 200) / 2 + 20, 200, 200)];
    nextButton.backgroundColor = DARK_GREY;
    nextButton.layer.cornerRadius = 100;
    nextButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:80];
    nextButton.alpha = 0.0;
    
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(startLevel) forControlEvents:UIControlEventTouchUpInside];
    
    stats = [[BBAStats alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH - 260), SCREEN_HEIGHT - 40)];
    
//    [self showNextButton];
}

- (void)startGame
{
    lives = 3;
    
    header.livesLeft = lives;
    [header showGame];
    
    [self startLevel];
}

- (void)startLevel
{
    [stats removeFromSuperview];
    
    levelController = [[BBALevelController alloc] initWithNibName:nil bundle:nil];
    levelController.delegate = self;
    
    levelController.view.frame = CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT - 40);
    [self.view addSubview:levelController.view];
    
    [nextButton removeFromSuperview];
    [startButton removeFromSuperview];
    [levelController runLevel:level];
}

- (void)gameWon
{
    // show game won & next level
    
    level++;
    
    [self showNextButton];
}

- (void)gameLost
{
    // show game lost & start over
    
    level = 0;
    header.currentScore = 0;
    
    [self showStartButton];
}

- (void)showStartButton
{
    header.topScore = topScore;
    [header showStart];
    
    [levelController.view removeFromSuperview];
    [self.view addSubview:startButton];
    
    startButton.alpha = 0.0;
    
    [UIView animateWithDuration:0.3 animations:^{
        startButton.alpha = 1.0;
    }];
}

- (void)showNextButton
{
    [levelController.view removeFromSuperview];
    [self.view addSubview:nextButton];
    
    [nextButton setTitle:[NSString stringWithFormat:@"%d",level + 1] forState:UIControlStateNormal];
    nextButton.alpha = 0.0;
    
    [UIView animateWithDuration:0.3 animations:^{
        nextButton.alpha = 1.0;
    }];
    
    [self.view addSubview:stats];
}

- (void)updatePoints:(int)points
{
    header.currentScore = points;
    if (header.currentScore > topScore)
    {
        topScore = header.currentScore;
        newHighScore = YES;
        
        // update my default value
        
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        
        [userDefaults setObject:@(topScore) forKey:@"topScore"];
        
        [userDefaults synchronize];
    }
}

- (int)loseLife
{
    if(lives > 0) lives--;
    
    header.livesLeft = lives;
    
    if(lives == 0) [self gameLost];
    
    return lives;
}

- (void)toggleColors
{
    // change colors
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden { return YES; }

@end
