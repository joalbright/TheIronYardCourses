//
//  CGDrawing.m
//  CGDrawing
//
//  Created by Jo Albright on 4/17/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "CGDrawing.h"

@implementation CGDrawing

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 20.0);
    
    [[UIColor redColor] set];
    
//    CGContextFillEllipseInRect(context, CGRectMake(100, 100, 100, 100));
    
    [[UIColor colorWithWhite:1.0 alpha:0.5] set];
    
//    CGContextStrokeEllipseInRect(context, CGRectMake(150, 100, 100, 100));
    
    
//    CGContextAddEllipseInRect(context, CGRectMake(200, 100, 100, 100));
//    CGContextStrokePath(context);
//    CGContextAddEllipseInRect(context, CGRectMake(100, 100, 100, 100));
//    CGContextStrokePath(context);
//    CGContextAddEllipseInRect(context, CGRectMake(150, 100, 100, 100));
//    
//    CGContextStrokePath(context);
    
//    CGContextAddEllipseInRect(context, CGRectMake(200, 100, 100, 100));
//    CGContextAddEllipseInRect(context, CGRectMake(100, 100, 100, 100));
//    CGContextAddEllipseInRect(context, CGRectMake(150, 100, 100, 100));
    
    CGContextFillPath(context);
    
    
    CGContextMoveToPoint(context, 50, 50);
    
    CGContextAddLineToPoint(context, 100, 100);
    
    CGContextStrokePath(context);
    
    
    CGContextMoveToPoint(context, 100, 50);
    CGContextAddLineToPoint(context, 100, 150);
//    CGContextAddLineToPoint(context, 50, 150);
//    CGContextAddLineToPoint(context, 50, 50);
    
    CGContextStrokePath(context);
}

@end
