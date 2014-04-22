//
//  BBAHeader.h
//  BrickBreaker
//
//  Created by Jo Albright on 4/18/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBAHeader : UIView

/// in game mode
@property (nonatomic) int currentScore;
@property (nonatomic) int livesLeft;

/// in start mode
@property (nonatomic) int topScore;

- (void)showStart;
- (void)showGame;

@end
