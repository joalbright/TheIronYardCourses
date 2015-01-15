//
//  ViewController.m
//  ScribbleTouch
//
//  Created by Jo Albright on 1/14/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

#import "ViewController.h"
#import "ScribbleView.h"
#import "ChoiceViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *blendModeButton;
@property (weak, nonatomic) IBOutlet UIButton *shapeTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *toggleButton;

@end

@implementation ViewController
{
    NSMutableDictionary * currentScribble;
    
    UIColor * selectedStrokeColor;
    int selectedStrokeWidth;
    
    UIColor * selectedFillColor;
    
    float shapeAlpha;
    
    NSString * selectedBlendMode;
    NSString * selectedShapeType;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    selectedStrokeColor = [UIColor blackColor];
    selectedStrokeWidth = 1;

}

- (IBAction)changeFillColor:(UIButton *)sender {
    
    selectedFillColor = sender.backgroundColor;
    
}


- (IBAction)changeStrokeColor:(UIButton *)sender {
    
    selectedStrokeColor = sender.backgroundColor;
    
}

- (IBAction)changeStrokeWidth:(UISlider *)sender {
    
    selectedStrokeWidth = sender.value;
    
}

- (IBAction)changeBlendMode:(id)sender {

    ChoiceViewController * choiceVC = [self.storyboard instantiateViewControllerWithIdentifier:@"choiceVC"];
    
    choiceVC.choices = @[
                         @"Normal",
                         @"Multiply",
                         @"Overlay",
                         @"Screen",
                         @"Clear"
                         ];
    
    [self presentViewController:choiceVC animated:NO completion:nil];
    
}

- (IBAction)changeShapeType:(id)sender {
    
    ChoiceViewController * choiceVC = [self.storyboard instantiateViewControllerWithIdentifier:@"choiceVC"];
    
    choiceVC.choices = @[
                         @"Scribble",
                         @"Line",
                         @"Rectangle",
                         @"Ellipse",
                         @"Triangle"
                         ];
    
    [self presentViewController:choiceVC animated:NO completion:nil];
}

- (IBAction)showHideDrawer:(id)sender {

    
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch * touch = touches.allObjects.firstObject;
    
    CGPoint location = [touch locationInView:self.view];
    
    
    currentScribble = [@{
                         
                         @"type":@"path",
                         @"fillColor":[UIColor clearColor],
                         @"strokeColor":selectedStrokeColor,
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
