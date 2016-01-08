//
//  PNAPixelWorldController.m
//  PixelNoise
//
//  Created by Jo Albright on 5/4/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "PNAPixelWorldController.h"
#import "PNAPixelSounds.h"
#import "PNAShape.h"

@interface PNAPixelWorldController () <UICollisionBehaviorDelegate>

@property (nonatomic) UICollisionBehavior * collisionBehavior;
@property (nonatomic) UIDynamicAnimator * animator;
@property (nonatomic) UIGravityBehavior * gravityBehavior;
@property (nonatomic) UIPushBehavior * pusher;

@end

@implementation PNAPixelWorldController
{
    PNAPixelSounds * sounds;
    NSArray * splatterDirections;
    NSArray * splatterStart;
    NSMutableArray * blocks;
    PNAShape * cloud;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.view.backgroundColor = [UIColor colorWithWhite:0.3 alpha:1.0];
        
        blocks = [@[] mutableCopy];
        splatterDirections = @[
//                               [NSValue valueWithCGPoint:CGPointMake(-0.00075, -0.00075)],
                               [NSValue valueWithCGPoint:CGPointMake(-0.0005, -0.0005)],
                               [NSValue valueWithCGPoint:CGPointMake(-0.00025, -0.0005)],
                               [NSValue valueWithCGPoint:CGPointMake(0.0, -0.0005)],
                               [NSValue valueWithCGPoint:CGPointMake(0.00025, -0.0005)],
                               [NSValue valueWithCGPoint:CGPointMake(0.0005, -0.0005)],
//                               [NSValue valueWithCGPoint:CGPointMake(0.00075, -0.00075)]
                               ];
        
        splatterStart = @[
                               @(-15),
                               @(-10),
                               @(-5),
                               @(0),
                               @(5),
                               @(10),
                               @(15),
                               ];
        
        sounds = [[PNAPixelSounds alloc] init];
        
        self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
        
        self.collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[]];
        
        self.collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
        self.collisionBehavior.collisionDelegate = self;
        
        [self.animator addBehavior:self.collisionBehavior];
        
        self.gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[]];
        
        [self.animator addBehavior:self.gravityBehavior];
        
        cloud = [[PNAShape alloc] initWithFrame:CGRectMake(20, 20, 200, 80)];
        cloud.tintColor = [UIColor whiteColor];
        cloud.points = @[
                         [NSValue valueWithCGPoint:CGPointMake(0, 20)],
                         [NSValue valueWithCGPoint:CGPointMake(40, 20)],
                         [NSValue valueWithCGPoint:CGPointMake(40, 0)],
                         [NSValue valueWithCGPoint:CGPointMake(160, 0)],
                         [NSValue valueWithCGPoint:CGPointMake(160, 30)],
                         [NSValue valueWithCGPoint:CGPointMake(200, 30)],
                         [NSValue valueWithCGPoint:CGPointMake(200, 70)],
                         [NSValue valueWithCGPoint:CGPointMake(140, 70)],
                         [NSValue valueWithCGPoint:CGPointMake(140, 80)],
                         [NSValue valueWithCGPoint:CGPointMake(80, 80)],
                         [NSValue valueWithCGPoint:CGPointMake(80, 60)],
                         [NSValue valueWithCGPoint:CGPointMake(0, 60)]
                         ];
        
//        [cloud setNeedsDisplay];
//        [self.view addSubview:cloud];
        
//        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(rainDrop) userInfo:nil repeats:YES];
        
    }
    return self;
}

- (void)rainDrop
{
    float x = cloud.frame.origin.x + (arc4random_uniform(10) * 20);
    float y = CGRectGetMidY(cloud.frame);
    
    [self createBlockWithLocation:CGPointMake(x, y)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    if([[(UIView *)item backgroundColor] isEqual:[UIColor whiteColor]])
    {
        for (NSValue *value in splatterDirections)
        {
            CGPoint point = [value CGPointValue];
            int index = (int)[splatterDirections indexOfObject:value];
            [self createShardWithLocation:CGPointMake(p.x + [splatterStart[index] intValue], p.y) andDirection:CGVectorMake(point.x, point.y)];
        }
        
        [blocks removeObjectIdenticalTo:item];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,(unsigned long)NULL), ^{

            [sounds playSoundWithName:@"Beat"];
            
        });
    }
    
//    if([[(UIView *)item backgroundColor] isEqual:[UIColor colorWithWhite:0.95 alpha:1.0]])
//    {
//        int random = arc4random_uniform(2) + 1;
//        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,(unsigned long)NULL), ^{
//
//            [sounds playSoundWithName:[NSString stringWithFormat:@"Droplet%d",random]];
//            
//        });
//    }
    
    [self.collisionBehavior removeItem:item];
    [(UIView *)item removeFromSuperview];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    CGPoint location = [[touches allObjects][0] locationInView:self.view];
//    
//    float x = location.x - cloud.frame.size.width/2;
//    
//    if(x < 20) x = 20;
//    if(x > SCREEN_WIDTH - 20 - cloud.frame.size.width) x = SCREEN_WIDTH - 20 - cloud.frame.size.width;
//    
//    [UIView animateWithDuration:0.4 animations:^{
//       
//        cloud.frame = CGRectMake(x, cloud.frame.origin.y, cloud.frame.size.width, cloud.frame.size.height);
//        
//    }];
    [self createBlockWithLocation:[[touches allObjects][0] locationInView:self.view]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self createBlockWithLocation:[[touches allObjects][0] locationInView:self.view]];
}

- (void)createBlockWithLocation:(CGPoint)location
{
    if([blocks count] >= 10) return;
    
    UIView * block = [[UIView alloc] initWithFrame:CGRectMake(location.x, location.y, 9, 9)];
    block.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:block];
    
    [blocks addObject:block];
    
    [self.gravityBehavior addItem:block];
    [self.collisionBehavior addItem:block];
}

- (void)createShardWithLocation:(CGPoint)location andDirection:(CGVector)direction
{
    UIView * shard = [[UIView alloc] initWithFrame:CGRectMake(location.x, location.y - 10, 3, 3)];
    shard.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    [self.view addSubview:shard];
    
    self.pusher = [[UIPushBehavior alloc] initWithItems:@[shard] mode:UIPushBehaviorModeInstantaneous];
    
    self.pusher.pushDirection = CGVectorMake(direction.dx, direction.dy);
    self.pusher.active = YES; // Because push is instantaneous, it will only happen once
    
    [self.animator addBehavior:self.pusher];
    
    [self.gravityBehavior addItem:shard];
    [self.collisionBehavior addItem:shard];
}

@end
