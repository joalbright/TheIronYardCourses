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

- (void)resetLevel;

@end

@protocol BBALevelDelegate <NSObject>

@optional

- (void)addPoints:(int)points;
- (void)gameWon;
- (int)loseLife; // return life count

@end
