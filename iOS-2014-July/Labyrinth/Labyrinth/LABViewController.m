//
//  LABViewController.m
//  Labyrinth
//
//  Created by Jo Albright on 8/14/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "LABViewController.h"

#import "LABGraphView.h"
#import <CoreMotion/CoreMotion.h>

@interface LABViewController ()

@end

@implementation LABViewController
{
    CMMotionManager * motionManager;
    
    UIDynamicAnimator * animator;
    UIGravityBehavior * gravityBehavior;
    UICollisionBehavior * collisionBehavior;
    UIDynamicItemBehavior * wallBehavior;
    
    float xRotation;
    float yRotation;
}

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

    animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    gravityBehavior = [[UIGravityBehavior alloc] init];
    [animator addBehavior:gravityBehavior];
    
    collisionBehavior = [[UICollisionBehavior alloc] init];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [animator addBehavior:collisionBehavior];
    
    wallBehavior = [[UIDynamicItemBehavior alloc] init];
    wallBehavior.density = 10000000000000;
    [animator addBehavior:wallBehavior];
    
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width);
    
    UIView * ball = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    ball.center = self.view.center;
    ball.backgroundColor = [UIColor magentaColor];
    ball.layer.cornerRadius = 20;
    [self.view addSubview:ball];
    
    [gravityBehavior addItem:ball];
    [collisionBehavior addItem:ball];
    
    UIView * wall = [[UIView alloc] initWithFrame:CGRectMake(50, 0, 50, 200)];
    wall.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:wall];
    
    [collisionBehavior addItem:wall];
    [wallBehavior addItem:wall];
    
//    LABGraphView * graphView = [[LABGraphView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width)];
//    
//    [self.view addSubview:graphView];
    
    motionManager = [[CMMotionManager alloc] init];
    
    [motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
       
        NSLog(@"x %f y %f z %f",motion.rotationRate.x,motion.rotationRate.y,motion.rotationRate.z);
        
        
        xRotation -= motion.rotationRate.x / 30;
        yRotation += motion.rotationRate.y / 30;
        
        [self updateGravity];
        
//        if (graphView.xPlots.count > self.view.frame.size.height / 10.0)
//        {
//            [graphView.xPlots removeObjectAtIndex:0];
//        }
//        
//        [graphView.xPlots addObject:@(motion.rotationRate.x * 200)];
//        [graphView setNeedsDisplay];
        
    }];
    
}

- (void)updateGravity
{
    gravityBehavior.gravityDirection = CGVectorMake(xRotation, yRotation);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    xRotation = yRotation = 0;
    [self updateGravity];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)prefersStatusBarHidden { return YES; }

@end
