//
//  BBALevelController.h
//  BrickBreaker
//
//  Created by Jo Albright on 4/17/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BBALevelDelegate;

@interface BBALevelController : UIViewController

@property (nonatomic,assign) id<BBALevelDelegate> delegate;

- (void)runLevel:(int)level;

@end

@protocol BBALevelDelegate <NSObject>

- (void)updatePoints:(int)points;
- (void)gameWon;
- (int)loseLife; // return life count

@end
