//
//  CARWheel.m
//  Car
//
//  Created by Jo Albright on 4/1/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "CARWheel.h"

@implementation CARWheel

- (id)init
{
    self = [super init];
    if (self)
    {
        self.tirePressure = 30;
        self.flat = NO;
        
        self.backgroundColor = [UIColor darkGrayColor];
        self.layer.cornerRadius = 20;
        
    }
    return self;
}

- (void)fillWithAir
{
    self.tirePressure = 30;
    self.flat = NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
