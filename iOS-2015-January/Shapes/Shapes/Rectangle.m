//
//  Rectangle.m
//  Shapes
//
//  Created by Jo Albright on 1/13/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

#import "Rectangle.h"

@implementation Rectangle


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor purpleColor] set];
    
//    CGContextFillRect(context, rect);
    
    CGContextMoveToPoint(context, 0, 0);
    
    CGContextAddLineToPoint(context, rect.size.width, 0);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    CGContextAddLineToPoint(context, 0, rect.size.height);
    CGContextAddLineToPoint(context, 0, 0);
    
    CGContextFillPath(context);
    
}


@end
