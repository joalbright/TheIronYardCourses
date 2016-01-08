//
//  PNAShape.m
//  PixelNoise
//
//  Created by Jo Albright on 5/4/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "PNAShape.h"

@implementation PNAShape

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGPoint start = [self.points[0] CGPointValue];
    
    [self.tintColor set];
    
    CGContextMoveToPoint(context, start.x, start.y);
    
    for (NSValue * pointValue in self.points)
    {
        CGPoint point = [pointValue CGPointValue];
        CGContextAddLineToPoint(context, point.x, point.y);
    }
    
    CGContextFillPath(context);
}


@end
