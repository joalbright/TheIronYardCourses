//
//  BBALevelController.m
//  BrickBreaker
//
//  Created by Jo Albright on 4/17/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "BBALevelController.h"

#import "BBALevelData.h"

#import <AVFoundation/AVFoundation.h>

#import "BBAGameData.h"

@interface BBALevelController () <UICollisionBehaviorDelegate,AVAudioPlayerDelegate>

//@property (nonatomic) AVAudioPlayer * player;
@property (nonatomic) NSMutableArray * players;

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

@property (nonatomic) UIGravityBehavior * fallingBricksDynamicProperties;

// attacher for paddle to move
@property (nonatomic) UIAttachmentBehavior * attacher;

@end

////////////////////////////////
////////////////////////////////
////////////////////////////////

@implementation BBALevelController
{    
    float paddleWidth;
    
    int levelPoints;
    int gamePoints;
    
    int bricksBroken;
    int livesLost;
    int paddleHits;
    
    int ceilingHits;
    int leftWallHits;
    int rightWallHits;
    
    BOOL ballWaiting;
    
    NSMutableDictionary * gameInfo;
    NSMutableDictionary * levelInfo;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
        
        self.bricks = [@[] mutableCopy];
        self.balls = [@[] mutableCopy];
        self.players = [@[] mutableCopy];
        
        paddleWidth = 80;
        
        gamePoints = 0;
        levelPoints = 0;
        bricksBroken = 0;
        livesLost = 0;
        paddleHits = 0;
        ceilingHits = 0;
        leftWallHits = 0;
        rightWallHits = 0;
    }
    return self;
}

- (void)playSoundWithName:(NSString *)soundName
{
    NSString * file = [[NSBundle mainBundle] pathForResource:soundName ofType:@"wav"];
    
    NSURL * url = [[NSURL alloc] initFileURLWithPath:file];
    
    AVAudioPlayer * player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    player.delegate = self;
    
    [self.players addObject:player];
    
    [player play];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self.players removeObjectIdenticalTo:player];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)runLevel:(int)level
{
    if(level == 0) gameInfo = [[BBALevelData dataCollection] newGame];
    else gameInfo = [[[BBALevelData dataCollection] games] lastObject];
    
    gamePoints = [gameInfo[@"score"] intValue];
    
    levelInfo = [@{
                   @"score":@0,
                   @"level":@(level),
                   @"paddle_hits":@0,
                   @"bricks_broken":@0,
                   @"lives_lost":@0,
                   @"wall_hits":[@{
                            @"ceiling":@0,
                            @"left":@0,
                            @"right":@0
                           } mutableCopy]
                   } mutableCopy];
    
    [gameInfo[@"levels"] addObject:levelInfo];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    [self createPaddle];
    
    self.collider = [[UICollisionBehavior alloc] initWithItems:@[self.paddle]];
    
    self.collider.collisionDelegate = self;
    self.collider.collisionMode = UICollisionBehaviorModeEverything;
//    self.collider.translatesReferenceBoundsIntoBoundary = YES;
    
    
    // run layout
    [self createBricksWithLayout:[[BBALevelData dataCollection] levelmaps][level]];
    
    int w = self.view.frame.size.width;
    int h = self.view.frame.size.height;
    
    [self.collider addBoundaryWithIdentifier:@"ceiling" fromPoint:CGPointMake(0, 0) toPoint:CGPointMake(w, 0)];
    [self.collider addBoundaryWithIdentifier:@"leftWall" fromPoint:CGPointMake(0, 0) toPoint:CGPointMake(0, h)];
    [self.collider addBoundaryWithIdentifier:@"rightWall" fromPoint:CGPointMake(w, 0) toPoint:CGPointMake(w, h)];
    [self.collider addBoundaryWithIdentifier:@"floor" fromPoint:CGPointMake(0, h + 10) toPoint:CGPointMake(w, h + 10)];
    
    [self.animator addBehavior:self.collider];
    
    //////////////////////
    
    self.ballsDynamicProperties = [self createPropertiesForItems:self.balls];
    self.bricksDynamicProperties = [self createPropertiesForItems:self.bricks];
    self.paddleDynamicProperties = [self createPropertiesForItems:@[self.paddle]];
    
    self.paddleDynamicProperties.density = 1000;
    self.bricksDynamicProperties.density = 1000;
    
    self.ballsDynamicProperties.elasticity = 1.0;
    self.ballsDynamicProperties.resistance = 0.0;
    
    
    [self createBall];

}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 atPoint:(CGPoint)p
{
    if([item1 isEqual:self.paddle] || [item2 isEqual:self.paddle])
    {
        [self playSoundWithName:@"retro_click"];
        paddleHits++;
        levelInfo[@"paddle_hits"] = @(paddleHits);
    }
    
    UIView * tempBrick;
    
    for (UIView * brick in self.bricks)
    {
        if([item1 isEqual:brick] || [item2 isEqual:brick])
        {
            if(brick.alpha > 0.2) brick.alpha -= 0.3;
            
            if(brick.alpha <= 0.11)
            {
                tempBrick = brick;
                
                // gravity for bricks
                [self.animator removeBehavior:self.fallingBricksDynamicProperties];
                self.fallingBricksDynamicProperties = [[UIGravityBehavior alloc] initWithItems:@[brick]];
                [self.animator addBehavior:self.fallingBricksDynamicProperties];
                
                [self.collider removeItem:brick];
                
                int value = (int)tempBrick.tag;
                
                levelPoints += value;
                gamePoints += value;
                bricksBroken++;
                
                
                
                NSInteger currentScore = [BBAGameData mainData].currentScore;
                
                [BBAGameData mainData].currentScore = currentScore + value;
                
                
                
                [self.delegate updatePoints:gamePoints];
                
                gameInfo[@"score"] = @(gamePoints);
                levelInfo[@"score"] = @(levelPoints);
                levelInfo[@"bricks_broken"] = @(bricksBroken);
                
//                NSLog(@"Total Points = %d",(int)points);
                
                // show point label
                [self pointLabelWithBrick:brick];
            }
        }
    }
    
    if(tempBrick != nil)
    {
        [self playSoundWithName:@"electric_alert"];
        [self.bricks removeObject:tempBrick];
        
        [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
            tempBrick.alpha = 0.0;
        } completion:^(BOOL finished) {
            [tempBrick removeFromSuperview];
            
            if([self.bricks count] == 0)
            {
                [self.animator removeBehavior:self.collider];
                [self.delegate gameWon];
            }
        }];
    }
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    UIView *tempBall;
    
    for (UIView * ball in self.balls)
    {
        if ([(NSString *)identifier isEqualToString:@"floor"] && [item isEqual:ball])
        {
//            NSLog(@"start over");
            [ball removeFromSuperview];
            [self.collider removeItem:ball];
            
            tempBall = ball;
            
            
        }
        
        if ([(NSString *)identifier isEqualToString:@"ceiling"] && [item isEqual:ball])
        {
            ceilingHits++;
            levelInfo[@"wall_hits"][@"ceiling"] = @(ceilingHits);
        }
        
        if ([(NSString *)identifier isEqualToString:@"leftWall"] && [item isEqual:ball])
        {
            leftWallHits++;
            levelInfo[@"wall_hits"][@"left"] = @(leftWallHits);
        }
        
        if ([(NSString *)identifier isEqualToString:@"rightWall"] && [item isEqual:ball])
        {
            rightWallHits++;
            levelInfo[@"wall_hits"][@"right"] = @(rightWallHits);
        }
    }
    
    if(tempBall != nil)
    {
        [self.balls removeObjectIdenticalTo:tempBall];
        
        if([self.balls count] == 0)
        {
            int livesLeft = [self.delegate loseLife];
            
            if(livesLeft > 0)
            {
                [self createBall];
            }
            
            livesLost++;
            
            levelInfo[@"lives_lost"] = @(livesLost);
        }
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

- (void)createPaddle
{
    self.paddle = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - paddleWidth) / 2, self.view.frame.size.height - 24, paddleWidth, 1)];
    
    self.paddle.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    [self.view addSubview:self.paddle];
    
    
    self.attacher = [[UIAttachmentBehavior alloc] initWithItem:self.paddle attachedToAnchor:CGPointMake(CGRectGetMidX(self.paddle.frame), CGRectGetMidY(self.paddle.frame))];
    
    [self.animator addBehavior:self.attacher];
    
    
    self.paddlePosition = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - paddleWidth) / 2, self.view.frame.size.height - 20, paddleWidth, 4)];
    
    self.paddlePosition.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    self.paddlePosition.layer.cornerRadius = 2;
    
    [self.view addSubview:self.paddlePosition];
}

- (void)createBricksWithLayout:(NSArray *)layout
{
    int brickRows = (int)[layout count];
    
    int brickGap = 6;
    
    float brickHeight = 16;
    
    for (int r = 0; r < brickRows; r++)
    {
        NSArray * column = layout[r];
        
        int brickCols = (int)[column count];
        
        float brickWidth = (self.view.frame.size.width - (brickGap * (brickCols - 1)) - 20) / brickCols;
        
        for (int c = 0; c < brickCols; c++)
        {
            int value = [column[c] intValue];
            
            if (value == 0) continue;
            
            float brickX = ((brickWidth + brickGap) * c) + 10;
            float brickY = ((brickHeight + brickGap) * r) + 10;
            
            UIView * brick = [[UIView alloc] initWithFrame:CGRectMake(brickX, brickY, brickWidth, brickHeight)];
            
            brick.layer.cornerRadius = 4;
            brick.backgroundColor = [UIColor whiteColor];
            
            brick.tag = value * 150;
            
            brick.alpha = 0.0;
            
            [self.view addSubview:brick];
            [self.bricks addObject:brick];
            [self.collider addItem:brick];
            
            [UIView animateWithDuration:0.3 delay:(0.05) * r + (0.05 * c) options:UIViewAnimationOptionCurveEaseOut animations:^{
                brick.alpha = 0.1 + (value * 0.3);
            } completion:^(BOOL finished) {}];
        }
    }
}

- (void)createBall
{
    int ballSize = 12;
    
    UIView * ball = [[UIView alloc] initWithFrame:CGRectMake(self.paddle.frame.origin.x + ((paddleWidth - ballSize) / 2), self.paddle.frame.origin.y - (ballSize + 4), ballSize, ballSize)];
    
//    UIImageView * ball = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y - 12, 10, 10)];
//    ball.image = [UIImage imageNamed:@"ball"];
    
    ball.backgroundColor = [UIColor whiteColor];
    ball.layer.cornerRadius = 6;
    
    [self.view addSubview:ball];
    
    // add ball to balls array
    [self.balls addObject:ball];
    
    [self.ballsDynamicProperties addItem:ball];
    [self.collider addItem:ball];
    
    ballWaiting = YES;
}

//// change ball direction

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint location = [[[touches allObjects] firstObject] locationInView:self.view];
    
    if(!ballWaiting)
    {
        [self movePaddleWithLocation:location];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint location = [[[touches allObjects] firstObject] locationInView:self.view];
    
    if(!ballWaiting)
    {
        [self movePaddleWithLocation:location];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint location = [[[touches allObjects] firstObject] locationInView:self.view];
    
    
    if(ballWaiting)
    {
        double angle = atan2(location.y - self.paddle.frame.origin.y - 20, location.x - CGRectGetMidX(self.paddle.frame));
        [self pushBallWithAngle:angle];
        
        ballWaiting = NO;
    } else {
        
        [self movePaddleWithLocation:location];
    }
}

- (void)pushBallWithAngle:(double)angle
{
    [self.animator removeBehavior:self.pusher];
    
    // Start ball off with a push
    self.pusher = [[UIPushBehavior alloc] initWithItems:self.balls mode:UIPushBehaviorModeInstantaneous];
    
    double dx = cos(angle);
    
    float thrust = 0.02;
    
    // set the highest delta to a 1.0 or -1.0
//    if(fabs(dx) > fabs(dy))
//    {
//        dx = dx / fabs(dx);
//        dy = dy / fabs(dx);
//    } else {
//        dx = dx / fabs(dy);
//        dy = dy / fabs(dy);
//    }
    
//    if(dy > -0.5) dy = dy - 0.5;
//    if(fabs(dx) < 0.5) dx = dx + (0.5 * direction(dx));
    
    CGVector vector = CGVectorMake(direction(dx), -1.0);
    
//    NSLog(@"%f",angle);
//    NSLog(@"%f , %f",vector.dx,vector.dy);
    
//    self.pusher.pushDirection = CGVectorMake(0.01, -0.01);
    self.pusher.pushDirection = CGVectorMake(thrust * vector.dx, thrust * vector.dy);
    self.pusher.active = YES; // Because push is instantaneous, it will only happen once
    
    [self.animator addBehavior:self.pusher];
}

- (void)movePaddleWithLocation:(CGPoint)location
{
    float locationX = location.x - (paddleWidth / 2);
    
    CGPoint origin = self.paddlePosition.frame.origin;
    
    if (locationX < 10) locationX = 10;
    if (locationX > self.view.frame.size.width - paddleWidth - 10) locationX = self.view.frame.size.width  - paddleWidth - 10;
    
//    NSLog(@"new y %f",locationX);
    
    self.attacher.anchorPoint = CGPointMake(locationX + (paddleWidth / 2), self.attacher.anchorPoint.y);
    
    [UIView animateWithDuration:0.1 animations:^{
        self.paddlePosition.frame = CGRectMake(locationX, origin.y, paddleWidth, 6);
    }];
}

int direction(double n) { return (n < 0) ? -1 : 1; }



//NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"Engine Bass 001"
//                                            withExtension: @"wav"];
//
//// Store the URL as a CFURLRef instance
//CFURLRef soundFileURLRef = (CFURLRef) [tapSound retain];
//SystemSoundID soundFileObject;
//
//// Create a system sound object representing the sound file.
//AudioServicesCreateSystemSoundID( soundFileURLRef, &soundFileObject );
//
//AudioServicesPlayAlertSound(soundFileObject);
@end
