//
//  SCGstageVC.m
//  Squares
//
//  Created by Jo Albright on 4/11/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "SCGStageVC.h"

#import "SCGSquare.h"

@implementation SCGStageVC
{
    int gameSize;
    
    NSArray * playerColors;
    
    int playerTurn;
    
    NSMutableDictionary * tappedDots;
    
    NSMutableDictionary * allSquares;

    UIView * gameBoard;
    
    NSArray * gameSizes;
    
    UIView * startScreen;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        
        playerColors = @[
                         [UIColor colorWithWhite:1.0 alpha:1.0],
                         [UIColor colorWithWhite:0.0 alpha:0.9]
                         ];
        
        playerTurn = 0;
        
        tappedDots = [@{} mutableCopy];
        
        allSquares = [@{} mutableCopy];
        
        gameSizes = @[@"4",@"6",@"8"];
        
        gameBoard = [[UIView alloc] initWithFrame:CGRectMake(0, (SCREEN_HEIGHT - SCREEN_WIDTH) / 2, SCREEN_WIDTH + 50, SCREEN_WIDTH + 50)];

        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = self.view.frame;
        gradient.colors = @[
                            (id)[UIColor colorWithRed:1.0 green:0.1 blue:0.3 alpha:1.0].CGColor,
                            (id)[UIColor colorWithRed:1.0 green:0.2 blue:0.2 alpha:1.0].CGColor
                            ];
        
        [self.view.layer insertSublayer:gradient atIndex:0];
        
        self.view.backgroundColor = [UIColor clearColor];
        
        [self.view addSubview:gameBoard];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    gameSize = [gameSizes[0] intValue];
    
    UISegmentedControl *gameSizeChoices = [[UISegmentedControl alloc] initWithItems:gameSizes];
    gameSizeChoices.frame = CGRectMake(60, SCREEN_HEIGHT - 50, 200, 30);
    gameSizeChoices.tintColor = [UIColor colorWithRed:0.5 green:0.1 blue:0.1 alpha:0.8];
    gameSizeChoices.selectedSegmentIndex = 0;
    [gameSizeChoices addTarget:self action:@selector(changeGameSize:) forControlEvents:UIControlEventValueChanged];
    
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20.0];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    [gameSizeChoices setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    [self.view addSubview:gameSizeChoices];
    
    [self resetGame];
}


- (void)startScreen
{
    
}


- (void)changeGameSize:(id)sender
{
    UISegmentedControl *radio = sender;
	
    int choice = (int)[radio selectedSegmentIndex];

    gameSize = [gameSizes[choice] intValue];
    
    [self resetGame];
}

- (void)resetGame
{
    for (UIView *view in gameBoard.subviews) [view removeFromSuperview];
    
    float circleWidth = SCREEN_WIDTH / gameSize;
    float squareWidth = circleWidth / 1.5;
    
    // create squares
    for (int sRow = 0; sRow < gameSize - 1; sRow++)
    {
        for (int sCol = 0; sCol < gameSize - 1; sCol++)
        {
            float squareOffset = circleWidth - ( squareWidth / 2 );
            
            float squareX = squareOffset + (circleWidth * sCol) + 25;
            float squareY = squareOffset + (circleWidth * sRow);
            
            SCGSquare * square = [[SCGSquare alloc] initWithFrame:CGRectMake(squareX, squareY, squareWidth, squareWidth)];
            
            square.layer.cornerRadius = squareWidth / 5;
            square.backgroundColor = [UIColor clearColor];
            
            NSString * key = [self formatKeyWithPosition:(CGPoint){sCol,sRow}]; // 0,1 c0r1
            
            allSquares[key] = square;
            
            [gameBoard addSubview:square];
        }
    }
    
    // create circles
    for (int row = 0; row < gameSize; row++)
    {
        for (int col = 0; col < gameSize; col++)
        {
            float circleX = circleWidth * col + 25;
            float circleY = (circleWidth * row);
            
            SCGCircle * circle = [[SCGCircle alloc] initWithFrame:CGRectMake(circleX, circleY, circleWidth, circleWidth)];
            
            circle.position = (CGPoint){col,row};
            circle.delegate = self;
            
            NSString * key = [self formatKeyWithPosition:(CGPoint){col,row}]; // 0,1 c0r1
            
            tappedDots[key] = @2;
            
            [gameBoard addSubview:circle];
        }
    }
}


- (UIColor *)circleTappedWithPosition:(CGPoint)position
{
    // check for square & stop if locked
    if([self checkForSquareAroundPosition:position]) return nil;
    
    UIColor * currentColor = playerColors[playerTurn];
    
    playerTurn = (playerTurn) ? 0 : 1;
    
    return currentColor;
}

- (BOOL)checkForSquareAroundPosition:(CGPoint)position
{
    NSString * key = [self formatKeyWithPosition:position];
    
    // stop if current dot is owned by same player
    if([tappedDots[key] isEqualToValue:@(playerTurn)]) return YES;
    
    BOOL used = NO;
    BOOL locked = NO;
    
    // x = col and y = row
    
    int pX = position.x;
    int pY = position.y;
    
    BOOL above = (pY > 0);
    BOOL below = (pY < gameSize - 1);
    BOOL left = (pX > 0);
    BOOL right = (pX < gameSize - 1);
    
    NSLog(@"checking locked");
    
    if (above && left)
        if([self checkIfLocked:(CGPoint){pX-1,pY-1}]) locked = YES;
    
    if (above && right)
        if([self checkIfLocked:(CGPoint){pX,pY-1}]) locked = YES;
    
    if (below && left)
        if([self checkIfLocked:(CGPoint){pX-1,pY}]) locked = YES;
    
    if (below && right)
        if([self checkIfLocked:(CGPoint){pX,pY}]) locked = YES;
    
    // set player num to value in tappedDots
    if(!locked)
    {
        NSLog(@"checking quadrants");
        
        tappedDots[key] = @(playerTurn);
        
        // check top left quadrant
        if (above && left)
            if ([self checkQuadrantForPosition:(CGPoint){pX-1,pY-1}]) used = YES;
        
        // check top right quadrant
        if (above && right)
            if ([self checkQuadrantForPosition:(CGPoint){pX,pY-1}]) used = YES;
        
        // check bottom left quadrant
        if (below && left)
            if ([self checkQuadrantForPosition:(CGPoint){pX-1,pY}]) used = YES;
        
        // check bottom right quadrant
        if (below && right)
            if ([self checkQuadrantForPosition:(CGPoint){pX,pY}]) used = YES;
    } else {
        used = YES;
    }
    
    return used;
}

- (BOOL)checkIfLocked:(CGPoint)position
{
    NSString * key = [self formatKeyWithPosition:position];
    
    SCGSquare * currentSquare = allSquares[key];
    
    BOOL colorsMatch = [currentSquare.backgroundColor isEqual:[UIColor clearColor]];
    
    if(!colorsMatch) return YES;
    
    return NO;
}

- (BOOL)checkQuadrantForPosition:(CGPoint)position
{
    NSLog(@"checking quadrant");
    
    int pX = position.x;
    int pY = position.y;
    
    NSString * topLeftDot = [self formatKeyWithPosition:(CGPoint){pX,pY}];
    NSString * topRightDot = [self formatKeyWithPosition:(CGPoint){pX+1,pY}];
    NSString * bottomLeftDot = [self formatKeyWithPosition:(CGPoint){pX,pY+1}];
    NSString * bottomRightDot = [self formatKeyWithPosition:(CGPoint){pX+1,pY+1}];
    
    // checks if top left and top right are the same
    BOOL topDotsSame = ([tappedDots[topLeftDot] isEqualToValue:tappedDots[topRightDot]]);
    // checks if bottom left and bottom right are the same
    BOOL bottomDotsSame = ([tappedDots[bottomLeftDot] isEqualToValue:tappedDots[bottomRightDot]]);
    // checks if top left and bottom left are the same
    BOOL leftDotsSame = ([tappedDots[topLeftDot] isEqualToValue:tappedDots[bottomLeftDot]]);

    // if top, left, & bottom dots are the same as the player's... then player owns the square
    if(topDotsSame && bottomDotsSame && leftDotsSame && [tappedDots[topLeftDot] isEqualToValue:@(playerTurn)])
    {
        SCGSquare * currentSquare = allSquares[topLeftDot];
        
        NSLog(@"taking spot");
        
        [UIView animateWithDuration:1.0 animations:^{
            
            currentSquare.backgroundColor = playerColors[playerTurn];
            
        }];
    }
    
    return NO;
}

- (NSString *)formatKeyWithPosition:(CGPoint)position
{
    int pX = position.x;
    int pY = position.y;
    
    return [NSString stringWithFormat:@"c%dr%d",pX,pY];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden { return YES; }

@end
