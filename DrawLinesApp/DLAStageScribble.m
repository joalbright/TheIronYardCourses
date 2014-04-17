//
//  DLAStageScribble.m
//  DrawLinesApp
//
//  Created by Jo Albright on 4/15/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "DLAStageScribble.h"


@implementation DLAStageScribble

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        // defaults
        self.lineWidth = 2.0;
        self.lineColor = [UIColor colorWithWhite:0.3 alpha:1.0];
        
        self.backgroundColor = [UIColor whiteColor];
        
        // init array
        self.lines = [@[] mutableCopy];
    }
    return self;
}

- (void)clearStage
{
    [self.lines removeAllObjects];
    
    [self setNeedsDisplay];
}

- (void)undoStage
{
    [self.lines removeLastObject];
    
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
//    CGContextClearRect(context, rect);
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    
    CGContextSetLineWidth(context, self.lineWidth);
    [self.lineColor set];
    
//    CGContextMoveToPoint(context, 50, 50);
//    CGContextAddCurveToPoint(context, 270, 50, 270, 400, 50, 400);
//    
//    CGContextStrokePath(context);
    
    for (NSDictionary * line in self.lines)
    {
        CGContextSetLineWidth(context, [line[@"width"] floatValue]);
        [(UIColor *)line[@"color"] set];
        
        NSArray * points = line[@"points"];
        
        CGPoint start = [points[0] CGPointValue];
        
        CGContextMoveToPoint(context, start.x, start.y);
        
        for (NSValue * value in points)
        {
//            int index = [points indexOfObject:value];
            
            CGPoint point = [value CGPointValue];
            
//            if (index > 0 || [scribble count] < 3)
                CGContextAddLineToPoint(context, point.x, point.y);
        }
        CGContextStrokePath(context);
    }
}

- (void)setLineWidth:(float)lineWidth
{
    _lineWidth = lineWidth;

    [self setNeedsDisplay];
}

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    
    [self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch * touch in touches)
    {
        CGPoint location = [touch locationInView:self];
        
//        [self.lines addObject:[@[
//                                [NSValue valueWithCGPoint:location]
//                                ] mutableCopy]];
        
        [self.lines addObject:[@{
                                @"color" : self.lineColor,
                                @"width" : @(self.lineWidth),
                                @"points" : [@[
                                               [NSValue valueWithCGPoint:location]
                                               ] mutableCopy]
                                } mutableCopy]];
    }
    
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self doTouch:touches];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self doTouch:touches];
}

- (void)doTouch:(NSSet *)touches
{
    UITouch * touch = [touches allObjects][0];
    CGPoint location = [touch locationInView:self];
    [[self.lines lastObject][@"points"] addObject:[NSValue valueWithCGPoint:location]];
    [self setNeedsDisplay];
}

@end
