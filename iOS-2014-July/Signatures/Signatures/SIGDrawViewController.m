//
//  SIGDrawViewController.m
//  Signatures
//
//  Created by Jo Albright on 8/14/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "SIGDrawViewController.h"

#import "SIGDrawView.h"

@interface SIGDrawViewController ()

@end

@implementation SIGDrawViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.drawView = [[SIGDrawView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    
    [self.view addSubview:self.drawView];
}

- (void)clearSignature
{
    [self.drawView.scribbles removeAllObjects];
    [self.drawView setNeedsDisplay];
}

- (UIImage *)getSignature
{
    UIImage * image = self.drawView.scribblesImage;
    
    [self clearSignature];
    
    return image;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{    
    UITouch * touch = [touches allObjects][0];
    CGPoint location = [touch locationInView:self.drawView];
    NSValue * pointValue = [NSValue valueWithCGPoint:location];
    
    self.drawView.currentScribble = [@[pointValue] mutableCopy];
    [self.drawView.scribbles addObject:self.drawView.currentScribble];
    
    [self.drawView setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches allObjects][0];
    CGPoint location = [touch locationInView:self.drawView];
    NSValue * pointValue = [NSValue valueWithCGPoint:location];
    
    [self.drawView.currentScribble addObject:pointValue];
    
    [self.drawView setNeedsDisplay];
}

@end
