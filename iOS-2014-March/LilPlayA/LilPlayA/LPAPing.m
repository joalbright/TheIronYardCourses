//
//  LPAPing.m
//  LilPlayA
//
//  Created by Jo Albright on 5/13/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "LPAPing.h"

@implementation LPAPing

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}

- (void)didMoveToWindow
{
    [self runPingWithDelay:0.0];
    
    // run at 0.5
    [self runPingWithDelay:0.5];
    
    [self runPingWithDelay:1.0];
    
    [self runPingWithDelay:1.5];
}

- (void)runPingWithDelay:(float)delay
{
    UIView * ping = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    ping.layer.borderWidth = 1.0;
    ping.layer.cornerRadius = 18.0;
    ping.layer.borderColor = self.tintColor.CGColor;
    
    [self addSubview:ping];
    
    [UIView animateWithDuration:2.0 delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        ping.frame = CGRectMake(-20, -20, self.frame.size.width + 40, self.frame.size.height + 40);
        ping.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [ping removeFromSuperview];
        [self runPingWithDelay:0.0];
        
    }];
}

@end
