//
//  SABGameScene.m
//  Stuffed Animal Battle
//
//  Created by Jo Albright on 5/15/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "SABGameScene.h"

////////

// Direction of player... fire from that direction

// Health Points for players
// Make the HP Bars represent HP points per player
// Make fireball remove HP points
// Sound Effects explosion, landing after jumping

// Research Sprite Characters
// Find Random Pictures online for your characters (PNG)

////////


@interface SABGameScene () <SKPhysicsContactDelegate>

@end

@implementation SABGameScene
{
    SKLabelNode * timerLabel;
    SKSpriteNode * player1HPBar;
    SKSpriteNode * player2HPBar;
    
    SKSpriteNode * buttonA;
    SKSpriteNode * buttonB;
    
    SKSpriteNode * dpadUp;
    SKSpriteNode * dpadDown;
    SKSpriteNode * dpadLeft;
    SKSpriteNode * dpadRight;
    
    SKSpriteNode * player1;
    SKSpriteNode * player2;
    
    SKTextureAtlas * charAtlas;
    SKTextureAtlas * danceAtlas;
}


- (instancetype)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        SKPhysicsBody * scenePhysics = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, size.width, size.height)];
        
        self.physicsBody = scenePhysics;
        
        self.physicsWorld.contactDelegate = self;
        
        SKSpriteNode * floor = [SKSpriteNode spriteNodeWithColor:[SKColor yellowColor] size:CGSizeMake(SCREEN_WIDTH, 30)];
        
        floor.position = CGPointMake(SCREEN_WIDTH / 2.0, 15);
        
        [self addChild:floor];
        
        SKPhysicsBody * floorPhysics = [SKPhysicsBody bodyWithRectangleOfSize:floor.size];
        
        floorPhysics.affectedByGravity = NO;
        floorPhysics.dynamic = NO;
        
        floor.physicsBody = floorPhysics;
        
        
        timerLabel = [SKLabelNode node];
        timerLabel.position = CGPointMake(SCREEN_WIDTH / 2.0, SCREEN_HEIGHT - 30);
        timerLabel.text = @"00:00";
        timerLabel.fontColor = [SKColor greenColor];
        timerLabel.fontSize = 16.0;
        
        [self addChild:timerLabel];
        
        
        float barArea = ((SCREEN_WIDTH - 60) / 2.0) - 20;
        
        player1HPBar = [SKSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:CGSizeMake(barArea, 20)];
        
        player1HPBar.position = CGPointMake((barArea + 20) / 2.0, SCREEN_HEIGHT - 20.0);
        
        [self addChild:player1HPBar];
        
        player2HPBar = [SKSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:CGSizeMake(barArea, 20)];
        
        player2HPBar.position = CGPointMake(SCREEN_WIDTH - (barArea + 20) / 2.0, SCREEN_HEIGHT - 20.0);
        
        [self addChild:player2HPBar];
        
        
        buttonA = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(40, 40)];
        
        buttonA.position = CGPointMake(SCREEN_WIDTH - 40, 80);
        
        [self addChild:buttonA];
        
        
        buttonB = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(40, 40)];
        
        buttonB.position = CGPointMake(SCREEN_WIDTH - 80, 40);
        
        [self addChild:buttonB];
        
        dpadDown = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(30, 30)];
        dpadDown.position = CGPointMake(80, 40);
        [self addChild:dpadDown];
        
        
        dpadUp = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(30, 30)];
        dpadUp.position = CGPointMake(80, 120);
        [self addChild:dpadUp];
        
        
        dpadLeft = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(30, 30)];
        dpadLeft.position = CGPointMake(40, 80);
        [self addChild:dpadLeft];
        
        
        dpadRight = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(30, 30)];
        dpadRight.position = CGPointMake(120, 80);
        [self addChild:dpadRight];
        
        
//        player1 = [SKSpriteNode spriteNodeWithColor:[SKColor whiteColor] size:CGSizeMake(40, 100)];
        
        
        charAtlas = [SKTextureAtlas atlasNamed:@"char"];
        danceAtlas = [SKTextureAtlas atlasNamed:@"dance"];
        
        player1 = [SKSpriteNode spriteNodeWithImageNamed:@"charframe1"];
        
        player1.position = CGPointMake(SCREEN_WIDTH / 4.0, 100);
        
        [self addChild:player1];
        
        SKPhysicsBody * player1Physics = [SKPhysicsBody bodyWithRectangleOfSize:player1.size];
        
        player1.physicsBody = player1Physics;
        
        //// dance
        
        NSMutableArray * textures = [@[] mutableCopy];
        
        for (int i = 1; i < danceAtlas.textureNames.count + 1; i++)
        {
            [textures addObject:[danceAtlas textureNamed:[NSString stringWithFormat:@"dance%d",i]]];
        }
        
        SKAction * dance = [SKAction animateWithTextures:textures timePerFrame:0.2];
        
        SKAction * danceAllNight = [SKAction repeatActionForever:dance];
        
        [player1 runAction:danceAllNight];
        
        ////
        
        
//        player2 = [SKSpriteNode spriteNodeWithColor:[SKColor whiteColor] size:CGSizeMake(40, 100)];
        
        player2 = [SKSpriteNode spriteNodeWithImageNamed:@"charframe1"];
        
        player2.position = CGPointMake(SCREEN_WIDTH * 0.75, 100);
        
        [self addChild:player2];
        
        SKPhysicsBody * player2Physics = [SKPhysicsBody bodyWithRectangleOfSize:player2.size];
        
        player2.physicsBody = player2Physics;
        
        player2.userData = [@{@"type":@"player2"} mutableCopy];
        
//        player2.physicsBody.contactTestBitMask = 1;
//        player2.physicsBody.categoryBitMask = 2;

    }
    return self;
}

- (void)update:(NSTimeInterval)currentTime
{
    
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    NSMutableArray * nodes = [@[] mutableCopy];
    
    if (contact.bodyA.node != nil) [nodes addObject:contact.bodyA.node];
    if (contact.bodyB.node != nil) [nodes addObject:contact.bodyB.node];
    
    for (SKNode * node in nodes)
    {
        if ([node.userData[@"type"] isEqualToString:@"fireball"])
        {
            [node removeFromParent];
            
            NSString *myParticlePath = [[NSBundle mainBundle] pathForResource:@"Explosion" ofType:@"sks"];
            
            SKEmitterNode *explosion = [NSKeyedUnarchiver unarchiveObjectWithFile:myParticlePath];
            
            explosion.position = contact.contactPoint;
            
            explosion.numParticlesToEmit = 200;
            
            [self addChild:explosion];
        }
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    
    CGPoint location = [touch locationInNode:self];

    [self testButtonsWithLocation:location];
    
}

- (void)buttonClick:(UIButton *)sender
{
    NSLog(@"%@",sender);
}

- (void)testButtonsWithLocation:(CGPoint)location
{
    NSArray * buttons = @[buttonA,buttonB,dpadUp,dpadDown,dpadLeft,dpadRight];
    
    for (SKNode * button in buttons)
    {
        if ([button containsPoint:location])
        {
            switch ([buttons indexOfObject:button])
            {
                case 0: // buttonA
                {
                    NSLog(@"Fire");
                    
//                    SKSpriteNode * fireball = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(10, 10)];
                    
                    NSString *myParticlePath = [[NSBundle mainBundle] pathForResource:@"FireBall" ofType:@"sks"];
                    
                    SKEmitterNode *fireball = [NSKeyedUnarchiver unarchiveObjectWithFile:myParticlePath];
                    
                    
                    fireball.position = CGPointMake(player1.position.x + 26.0, player1.position.y);
                    
                    SKPhysicsBody * fireballPhysics = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(10, 10)];
                    
                    fireballPhysics.affectedByGravity = NO;
                    
                    fireball.physicsBody = fireballPhysics;
                    
                    fireball.physicsBody.contactTestBitMask = 1;
                    
                    fireball.userData = [@{@"type":@"fireball"} mutableCopy];
                    
                    [self addChild:fireball];
                    
                    [fireball.physicsBody applyImpulse:CGVectorMake(3.0, 0.0)];

                    
                    
                }
                    break;
                    
                case 1: // buttonB
                    NSLog(@"Punch");
                    break;
                    
                    
                case 2: // up
                {
                    NSLog(@"Jump");
                    
                    
//                    for (NSString * textureName in charAtlas.textureNames)
//                    {
//                        NSLog(@"%@",textureName);
//                    }
                    
                    NSMutableArray * textures = [@[] mutableCopy];
                    
                    for (int i = 1; i < charAtlas.textureNames.count + 1; i++)
                    {
                        [textures addObject:[charAtlas textureNamed:[NSString stringWithFormat:@"charframe%d",i]]];
                    }
                    
                    SKAction * setFrame2 = [SKAction animateWithTextures:textures timePerFrame:0.2];
                    
                    [player1 runAction:setFrame2];
                    
                    [player1.physicsBody applyImpulse:CGVectorMake(0.0, 100.0)];
                    
//                    static const CGFloat thrust = 0.12;
//                    [player1.physicsBody applyTorque:thrust];
                }
                    break;
                    
                case 3: // down
                    NSLog(@"Duck");
                    break;
                    
                case 4: // left
                {
                    NSLog(@"Move Left");
                    
                    
                    [player1.physicsBody applyImpulse:CGVectorMake(-20.0, 0.0)];
                    
                    
                }
                    break;
                    
                case 5: // right
                {
                    NSLog(@"Move Right");
                    
                    [player1.physicsBody applyImpulse:CGVectorMake(20.0, 0.0)];
                }
                    break;
                    
                default:
                    break;
            }
        }
    }
}

@end
