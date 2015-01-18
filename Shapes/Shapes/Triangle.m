//
//  Triangle.m
//  Shapes
//
//  Created by Jo Albright on 1/14/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

#import "Triangle.h"

IB_DESIGNABLE
@implementation Triangle

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor blueColor] set];
    
    CGContextMoveToPoint(context, rect.size.width / 2, 0);
    
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    CGContextAddLineToPoint(context, 0, rect.size.height);
    CGContextAddLineToPoint(context, rect.size.width / 2, 0);
    
    CGContextFillPath(context);
    
}

@end
