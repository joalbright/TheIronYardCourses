//
//  GameViewController.m
//  PixelAdventure
//
//  Created by Jo Albright on 6/8/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@implementation SKScene (Unarchive)

+ (instancetype)unarchiveFromFile:(NSString *)file {
    /* Retrieve scene file path from the application bundle */
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    /* Unarchive the file to an SKScene object */
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    
    return scene;
}

@end

@implementation GameViewController
{
    GameScene * scene;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    
    // Create and configure the scene.
    scene = [GameScene unarchiveFromFile:@"GameScene"];
    scene.scaleMode = SKSceneScaleModeResizeFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (IBAction)pressedDown:(UIButton *)sender {
    
    CGFloat direction = ([sender.titleLabel.text isEqualToString:@"A"]) ? -50 : 50;
    
    [scene changePixelDirection:direction];
    
}

- (IBAction)releasedButton:(UIButton *)sender {
    
    [scene changePixelDirection:0];
    
}


- (IBAction)moveButtonPressed:(UIButton *)sender {
    
    NSArray * letters = @[@"W",@"A",@"S",@"D"];
    
    int index = (int)[letters indexOfObject:sender.titleLabel.text];
    
    NSArray * directions = @[
                             [NSValue valueWithCGVector:CGVectorMake(0.0, 30.0)],
                             [NSValue valueWithCGVector:CGVectorMake(-10.0, 0.0)],
                             [NSValue valueWithCGVector:CGVectorMake(0.0, -10.0)],
                             [NSValue valueWithCGVector:CGVectorMake(10.0, 0.0)]
                             ];
    
    [scene movePixelInDirection:[directions[index] CGVectorValue]];
    
}

- (IBAction)fireButtonPressed:(UIButton *)sender {
    
    if ([sender.titleLabel.text isEqualToString:@"1"]) {
        
        [scene normalAttack];
        
    }
    
    if ([sender.titleLabel.text isEqualToString:@"2"]) {
        
        [scene specialAttack];
        
    }
    
}


- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
