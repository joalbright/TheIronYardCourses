//
//  ViewController.m
//  ScribbleTouch
//
//  Created by Jo Albright on 1/14/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

#import "ViewController.h"
#import "ScribbleView.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSMutableDictionary * currentScribble;
    UIColor * selectedColor;
    int selectedStrokeWidth;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    selectedColor = [UIColor blackColor];
    selectedStrokeWidth = 1;

}

- (IBAction)changeColor:(UIButton *)sender {
    
    selectedColor = sender.backgroundColor;
    
}

- (IBAction)changeStrokeWidth:(UISlider *)sender {
    
    selectedStrokeWidth = sender.value;
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch * touch = touches.allObjects.firstObject;
    
    CGPoint location = [touch locationInView:self.view];
    
    
    currentScribble = [@{
                         
                         @"type":@"path",
                         @"fillColor":[UIColor clearColor],
                         @"strokeColor":selectedColor,
                         @"strokeWidth":@(selectedStrokeWidth),
                         @"points":[@[[NSValue valueWithCGPoint:location]] mutableCopy]
                         
                         } mutableCopy];
    
    ScribbleView * sView = (ScribbleView *)self.view;
    [sView.scribbles addObject:currentScribble];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch * touch = touches.allObjects.firstObject;
    
    CGPoint location = [touch locationInView:self.view];
    
    [currentScribble[@"points"] addObject:[NSValue valueWithCGPoint:location]];
    
    [self.view setNeedsDisplay];
}

@end
