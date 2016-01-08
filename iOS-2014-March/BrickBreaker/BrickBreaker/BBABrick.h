//
//  BBABrick.h
//  BrickBreaker
//
//  Created by Jo Albright on 4/18/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    BrickTypeA,
    BrickTypeB,
    BrickTypeC,
} BrickType;

@interface BBABrick : UIView

@property (nonatomic) int points;
@property (nonatomic) BrickType brickType;

@end
