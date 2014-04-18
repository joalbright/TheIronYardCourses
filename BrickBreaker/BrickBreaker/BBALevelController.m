//
//  BBALevelController.m
//  BrickBreaker
//
//  Created by Jo Albright on 4/17/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "BBALevelController.h"

@interface BBALevelController () <UICollisionBehaviorDelegate>

@property (nonatomic) UIView * paddle;
@property (nonatomic) UIView * paddlePosition;

@property (nonatomic) NSMutableArray * balls;
@property (nonatomic) NSMutableArray * bricks;

// dynamics animator
@property (nonatomic) UIDynamicAnimator * animator;

// pushes the ball
@property (nonatomic) UIPushBehavior * pusher;

// handles collisions
@property (nonatomic) UICollisionBehavior * collider;

// item behavior properties
@property (nonatomic) UIDynamicItemBehavior * paddleDynamicProperties;
@property (nonatomic) UIDynamicItemBehavior * ballsDynamicProperties;
@property (nonatomic) UIDynamicItemBehavior * bricksDynamicProperties;

@property (nonatomic) UIAttachmentBehavior * attacher;

@end

////////////////////////////////
////////////////////////////////
////////////////////////////////

@implementation BBALevelController
{
    float paddleWidth;
    float points;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.bricks = [@[] mutableCopy];
        self.balls = [@[] mutableCopy];
        
        paddleWidth = 80;
        points = 0;
        
        self.view.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1.0];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen:)];
        
        [self.view addGestureRecognizer:tap];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)resetLevel
{
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    [self createPaddle];
    
    [self createBall];
    
    [self createBricks];
    
    self.collider = [[UICollisionBehavior alloc] initWithItems:[self allItems]];
    
    self.collider.collisionDelegate = self;
    self.collider.collisionMode = UICollisionBehaviorModeEverything;
//    self.collider.translatesReferenceBoundsIntoBoundary = YES;
    
    int w = self.view.frame.size.width;
    int h = self.view.frame.size.height;
    
    [self.collider addBoundaryWithIdentifier:@"ceiling" fromPoint:CGPointMake(0, 0) toPoint:CGPointMake(w, 0)];
    
    [self.collider addBoundaryWithIdentifier:@"leftWall" fromPoint:CGPointMake(0, 0) toPoint:CGPointMake(0, h)];
    
    [self.collider addBoundaryWithIdentifier:@"rightWall" fromPoint:CGPointMake(w, 0) toPoint:CGPointMake(w, h)];
    
    [self.collider addBoundaryWithIdentifier:@"floor" fromPoint:CGPointMake(0, h + 10) toPoint:CGPointMake(w, h + 10)];
    
    [self.animator addBehavior:self.collider];
    
//    [self.animator removeAllBehaviors];
    
    //////////////////////
    
    self.ballsDynamicProperties = [self createPropertiesForItems:self.balls];
    self.bricksDynamicProperties = [self createPropertiesForItems:self.bricks];
    self.paddleDynamicProperties = [self createPropertiesForItems:@[self.paddle]];
    
    self.paddleDynamicProperties.density = 1000;
    self.bricksDynamicProperties.density = 1000;
    
    self.ballsDynamicProperties.elasticity = 1.0;
    self.ballsDynamicProperties.resistance = 0.0;

}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 atPoint:(CGPoint)p
{
    NSLog(@"%@ /n %@",item1,item2);
    
    UIView * tempBrick;
    
    for (UIView * brick in self.bricks)
    {
        if([item1 isEqual:brick] || [item2 isEqual:brick])
        {
            
            if(brick.alpha == 0.5)
            {
                tempBrick = brick;
                [brick removeFromSuperview];
                [self.collider removeItem:brick];
                
                points += brick.tag;
                
                NSLog(@"Total Points = %d",(int)points);
                
                [self pointLabelWithBrick:brick];
            }
            
            brick.alpha = 0.5;
        }
    }
    
    if(tempBrick != nil)
    {
        [self.bricks removeObject:tempBrick];
        
        if([self.bricks count] == 0)
            if([self.delegate respondsToSelector:@selector(gameDone)])
                [self.delegate gameDone];
    }
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    if ([(NSString *)identifier isEqualToString:@"floor"])
    {
        UIView * ball = (UIView *)item;
        
//        NSLog(@"start over");
        [ball removeFromSuperview];
        [self.balls removeObject:ball];
        [self.collider removeItem:ball];
        
        if([self.balls count] == 0 && [self.delegate respondsToSelector:@selector(gameDone)])
            [self.delegate gameDone];
    }
}

- (void)pointLabelWithBrick:(UIView *)brick
{
    UILabel * label = [[UILabel alloc] initWithFrame:brick.frame];
    
    label.text = [NSString stringWithFormat:@"+%d",(int)brick.tag];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    
    [self.view addSubview:label];
    
    [UIView animateWithDuration:0.4 animations:^{
        label.alpha = 0.0;
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
    }];
}

- (UIDynamicItemBehavior *)createPropertiesForItems:(NSArray *)items
{
    UIDynamicItemBehavior * properties = [[UIDynamicItemBehavior alloc] initWithItems:items];
    properties.allowsRotation = NO;
    properties.friction = 0.0;
    [self.animator addBehavior:properties];
    return properties;
}

- (NSArray *)allItems
{
    NSMutableArray * items = [@[self.paddle] mutableCopy];
    
    for (UIView * item in self.balls) [items addObject:item];
    for (UIView * item in self.bricks) [items addObject:item];
    
    return items;
}

- (void)createPaddle
{
    self.paddle = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - paddleWidth) / 2, SCREEN_HEIGHT - 24, paddleWidth, 1)];
    
    self.paddle.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    [self.view addSubview:self.paddle];
    
    
    self.attacher = [[UIAttachmentBehavior alloc] initWithItem:self.paddle attachedToAnchor:CGPointMake(CGRectGetMidX(self.paddle.frame), CGRectGetMidY(self.paddle.frame))];
    
    [self.animator addBehavior:self.attacher];
    
    
    self.paddlePosition = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - paddleWidth) / 2, SCREEN_HEIGHT - 20, paddleWidth, 4)];
    
    self.paddlePosition.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    self.paddlePosition.layer.cornerRadius = 2;
    
    [self.view addSubview:self.paddlePosition];
}

- (void)createBricks
{
    int brickCols = 8;
    int brickRows = 4;
    
    float brickWidth = (SCREEN_WIDTH - (10 * (brickCols + 1))) / brickCols;
    float brickHeight = 20;

    for (int c = 0; c < brickCols; c++)
    {
        for (int r = 0; r < brickRows; r++)
        {
            float brickX = ((brickWidth + 10) * c) + 10;
            float brickY = ((brickHeight + 10) * r) + 10;
            
            UIView * brick = [[UIView alloc] initWithFrame:CGRectMake(brickX, brickY, brickWidth, brickHeight)];
            
            brick.layer.cornerRadius = 6;
            brick.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1.0];
            
            int random = arc4random_uniform(5) * 50 + 50;
            brick.tag = random;
            
//            [self.collider addItem:brick];
            
            [self.view addSubview:brick];
            [self.bricks addObject:brick];
        }
    }
}

- (void)createBall
{
    UIView * ball = [[UIView alloc] initWithFrame:CGRectMake(self.paddle.frame.origin.x, self.paddle.frame.origin.y - 20, 10, 10)];
    
//    UIImageView * ball = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y - 12, 10, 10)];
//    ball.image = [UIImage imageNamed:@"ball"];
    
    ball.backgroundColor = [UIColor whiteColor];
    ball.layer.cornerRadius = 5;
    
    [self.view addSubview:ball];
    
    // add ball to balls array
    [self.balls addObject:ball];
    
    // Start ball off with a push
    self.pusher = [[UIPushBehavior alloc] initWithItems:@[ball] mode:UIPushBehaviorModeInstantaneous];
    
    self.pusher.pushDirection = CGVectorMake(0.01, 0.01);
    self.pusher.active = YES; // Because push is instantaneous, it will only happen once
    
    [self.animator addBehavior:self.pusher];
}

- (void)tapScreen:(UITapGestureRecognizer *)gr
{
    CGPoint location = [gr locationInView:self.view];
    
    float locationX = location.x - (paddleWidth / 2);
    
    CGPoint origin = self.paddlePosition.frame.origin;
    
    if (locationX < 10) locationX = 10;
    if (locationX > SCREEN_WIDTH - paddleWidth - 10) locationX = SCREEN_WIDTH  - paddleWidth - 10;
    
//    NSLog(@"new y %f",locationX);
    
    self.attacher.anchorPoint = CGPointMake(locationX + (paddleWidth / 2), self.attacher.anchorPoint.y);
    
    [UIView animateWithDuration:0.1 animations:^{
        self.paddlePosition.frame = CGRectMake(locationX, origin.y, paddleWidth, 6);
    }];
}

@end
