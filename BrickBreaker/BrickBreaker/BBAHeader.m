//
//  BBAHeader.m
//  BrickBreaker
//
//  Created by Jo Albright on 4/18/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "BBAHeader.h"

@implementation BBAHeader
{
    UIView * line;
    
    UILabel * topScoreLabel;
    
    UILabel * currentScoreLabel;
    
    NSMutableArray * allLives;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        allLives = [@[] mutableCopy];
        
        self.backgroundColor = [UIColor clearColor];
        self.currentScore = 0;
        self.topScore = 0;
        
        line = [[UIView alloc] initWithFrame:CGRectMake(10, frame.size.height - 1, frame.size.width - 20, 1)];
        
        line.backgroundColor = DARK_GREY;
        
        [self addSubview:line];
    }
    return self;
}

- (void)showStart
{
    [currentScoreLabel removeFromSuperview];
    
    topScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, 40)];
    topScoreLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
    topScoreLabel.textColor = LIGHT_GREY;
    topScoreLabel.text = [NSString stringWithFormat:@"Top Score : %d",self.topScore];
    topScoreLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:topScoreLabel];
}

- (void)showGame
{
    [topScoreLabel removeFromSuperview];
    
    currentScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, 40)];
    currentScoreLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
    currentScoreLabel.textColor = LIGHT_GREY;
    currentScoreLabel.textAlignment = NSTextAlignmentRight;
    
    [self addSubview:currentScoreLabel];
    
    [self updateLives];
}

- (void)setTopScores:(int)topScore
{
    _topScore = topScore;
    
    topScoreLabel.text = [NSString stringWithFormat:@"Top Score : %d",topScore];
}

- (void)setCurrentScore:(int)currentScore
{
    _currentScore = currentScore;
    
    currentScoreLabel.text = [NSString stringWithFormat:@"Score : %d",currentScore];
}

- (void)setLivesLeft:(int)livesLeft
{
    _livesLeft = livesLeft;
    
    [self updateLives];
}

- (void)updateLives
{
    for (UIView * life in allLives) [life removeFromSuperview];
    
    for (int i = 0; i < self.livesLeft; i++)
    {
        UIView * life = [[UIView alloc] initWithFrame:CGRectMake(((10 + 5) * i) + 10, 15, 10, 10)];
        life.layer.cornerRadius = 5;
        life.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        
        [self addSubview:life];
        [allLives addObject:life];
    }
}

@end
