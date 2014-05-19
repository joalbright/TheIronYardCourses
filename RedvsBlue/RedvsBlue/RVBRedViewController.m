//
//  RVBRedViewController.m
//  RedvsBlue
//
//  Created by Jo Albright on 5/7/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "RVBRedViewController.h"

#import "RVBData.h"

@interface RVBRedViewController ()

@end

@implementation RVBRedViewController

- (id)initWithFrame:(CGRect)frame andColor:(UIColor *)color
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        self.view.backgroundColor = color;
        self.view.frame = frame;
    }
    return self;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([self.view.backgroundColor isEqual:[UIColor redColor]])
    {
        [RVBData mainData].redScore++;
        // red
    } else {
        // blue
        [RVBData mainData].blueScore++;
    }
    
    [self.delegate updateScore];
}

@end
