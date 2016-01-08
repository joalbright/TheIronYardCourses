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

@interface ViewController () <ChoiceViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *blendModeButton;
@property (weak, nonatomic) IBOutlet UIButton *shapeTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *toggleButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *drawerLeftConstraint;

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

    selectedFillColor = [UIColor clearColor];
    selectedStrokeColor = [UIColor blackColor];
    selectedStrokeWidth = 1;
    selectedBlendMode = @"Normal";
    selectedShapeType = @"Scribble";
    shapeAlpha = 1;

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

- (void)choice:(NSString *)choice forGroup:(NSString *)group {
    
    if ([group isEqualToString:@"BlendMode"]) {
        
        selectedBlendMode = choice;
        [self.blendModeButton setTitle:choice forState:UIControlStateNormal];
        
    }
    
    if ([group isEqualToString:@"ShapeType"]) {
        
        selectedShapeType = choice;
        [self.shapeTypeButton setTitle:choice forState:UIControlStateNormal];
        
    }
    
    NSLog(@"Choice = %@ for Group %@",choice,group);
}

- (IBAction)changeBlendMode:(id)sender {

    ChoiceViewController * choiceVC = [self.storyboard instantiateViewControllerWithIdentifier:@"choiceVC"];
    
    choiceVC.delegate = self;
    choiceVC.group = @"BlendMode";
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
    
    choiceVC.delegate = self;
    choiceVC.group = @"ShapeType";
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
    
    int direction = (self.drawerLeftConstraint.constant == -16) ? -1 : 1;
    
    self.toggleButton.transform = CGAffineTransformMakeScale(direction, 1);
    
    self.drawerLeftConstraint.constant = (self.drawerLeftConstraint.constant == -16) ? -266 : -16;
    
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch * touch = touches.allObjects.firstObject;
    
    CGPoint location = [touch locationInView:self.view];
    
    
    currentScribble = [@{
                         
                         @"type":selectedShapeType,
                         @"blend":selectedBlendMode,
                         @"fillColor":selectedFillColor,
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
    
    if ([selectedShapeType isEqualToString:@"Scribble"]) {
        
        [currentScribble[@"points"] addObject:[NSValue valueWithCGPoint:location]];
        
    } else {
        
        currentScribble[@"points"][1] = [NSValue valueWithCGPoint:location];
        
    }
    
    
    [self.view setNeedsDisplay];
}

@end
