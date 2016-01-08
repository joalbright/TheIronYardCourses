//
//  BBAStats.m
//  BrickBreaker
//
//  Created by Jo Albright on 4/20/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "BBAStats.h"

#import "BBALevelData.h"

@implementation BBAStats
{
    UILabel * levelLabel;
    UILabel * scoreLabel;
    UILabel * brokenBricks;
    UILabel * livesLost;
    UILabel * paddleHits;
    UILabel * wallHits;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        
        levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 200, 50)];
        levelLabel.textColor = [UIColor whiteColor];
        levelLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:30];
        
        [self addSubview:levelLabel];
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(10, 150, self.frame.size.width - 80, 1)];
        line.backgroundColor = LIGHT_GREY;
        
        [self addSubview:line];
        
        scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 155, 200, 30)];
        scoreLabel.textColor = [UIColor whiteColor];
        scoreLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18];
        
        [self addSubview:scoreLabel];
        
        brokenBricks = [[UILabel alloc] initWithFrame:CGRectMake(10, 175, 200, 30)];
        brokenBricks.textColor = [UIColor whiteColor];
        brokenBricks.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18];
        
        [self addSubview:brokenBricks];
        
        livesLost = [[UILabel alloc] initWithFrame:CGRectMake(10, 195, 200, 30)];
        livesLost.textColor = [UIColor whiteColor];
        livesLost.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18];
        
        [self addSubview:livesLost];
        
        paddleHits = [[UILabel alloc] initWithFrame:CGRectMake(10, 215, 200, 30)];
        paddleHits.textColor = [UIColor whiteColor];
        paddleHits.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18];
        
        [self addSubview:paddleHits];
        
        wallHits = [[UILabel alloc] initWithFrame:CGRectMake(10, 235, 200, 30)];
        wallHits.textColor = [UIColor whiteColor];
        wallHits.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18];
        
        [self addSubview:wallHits];
    }
    return self;
}

- (void)didMoveToWindow
{
    NSDictionary * gameInfo = [[[BBALevelData dataCollection] games] lastObject];
    
    NSDictionary * levelInfo = [gameInfo[@"levels"] lastObject];
    
    levelLabel.text = [NSString stringWithFormat:@"Level %d",[levelInfo[@"level"] intValue] + 1];
    
    scoreLabel.text = [NSString stringWithFormat:@"Score : %d",[levelInfo[@"score"] intValue]];
    brokenBricks.text = [NSString stringWithFormat:@"Broken Bricks : %d",[levelInfo[@"bricks_broken"] intValue]];
    livesLost.text = [NSString stringWithFormat:@"Lives Lost : %d",[levelInfo[@"lives_lost"] intValue]];
    paddleHits.text = [NSString stringWithFormat:@"Paddle Hits : %d",[levelInfo[@"paddle_hits"] intValue]];
    wallHits.text = [NSString stringWithFormat:@"Wall Hits : %d",[levelInfo[@"wall_hits"][@"ceiling"] intValue] + [levelInfo[@"wall_hits"][@"left"] intValue] + [levelInfo[@"wall_hits"][@"right"] intValue]];
}

@end
