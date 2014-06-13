//
//  LPAViewController.m
//  LilPlayA
//
//  Created by Jo Albright on 5/13/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "LPAViewController.h"

#import <AVFoundation/AVFoundation.h>

#import "LPAPing.h"

#define GREEN_COLOR [UIColor colorWithRed:0.173f green:1.000f blue:0.816f alpha:1.0f]
#define RED_COLOR [UIColor colorWithRed:1.000f green:0.122f blue:0.290f alpha:1.0f]

@interface LPAViewController ()
{
    AVAudioPlayer * player;
    
    UIView * seekButton;
    UIView * progressBar;
    UIView * playedBar;
    
    NSTimer * timer;
    
    UIButton * playButton;
    
    BOOL trackIsLoaded;
    
    CGPoint panVolume;
    float panWidth;
    UIView * panVolumeArea;
    LPAPing * panVolumeButton;
    
    float pan;
    float volume;
}

@end

@implementation LPAViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = self.view.frame;
        gradient.colors = @[
                            (id)GREEN_COLOR.CGColor,
                            (id)[UIColor whiteColor].CGColor
                            ];
        
        [self.view.layer insertSublayer:gradient atIndex:0];
        
        int w = [UIScreen mainScreen].bounds.size.width;
        int h = [UIScreen mainScreen].bounds.size.height;
        
        playButton = [[UIButton alloc] initWithFrame:CGRectMake(100, h - 70, 50, 50)];
        playButton.layer.cornerRadius = 25;
        
        [playButton addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
        
        [playButton setImage:[self getImageWithName:@"play"] forState:UIControlStateNormal];
        
        playButton.adjustsImageWhenHighlighted = NO;

        [self.view addSubview:playButton];
        
        
        UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:playButton.frame];
        
        activityIndicator.color = [UIColor whiteColor];
        
        [self.view addSubview:activityIndicator];
        
        [activityIndicator startAnimating];
        
        
        UIButton * stopButton = [[UIButton alloc] initWithFrame:CGRectMake(w - 150, h - 70, 50, 50)];
        stopButton.layer.cornerRadius = 25;
        
        [stopButton setImage:[self getImageWithName:@"stop"] forState:UIControlStateNormal];
        
        [stopButton addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
        
        stopButton.adjustsImageWhenHighlighted = NO;

        
        [self.view addSubview:stopButton];
        
        
        progressBar = [[UIView alloc] initWithFrame:CGRectMake(20, h - 100, w - 40, 2)];
        progressBar.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.1];
        progressBar.layer.cornerRadius = 1;

        
        [self.view addSubview:progressBar];
        
        
        playedBar = [[UIView alloc] initWithFrame:CGRectMake(progressBar.frame.origin.x, progressBar.frame.origin.y, 2, 2)];
        playedBar.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        playedBar.layer.cornerRadius = 1;
        
        [self.view addSubview:playedBar];
        
        
        seekButton = [[UIView alloc] initWithFrame:CGRectMake(progressBar.frame.origin.x - 9, progressBar.frame.origin.y - 9, 20, 20)];
        seekButton.layer.cornerRadius = 10;
        seekButton.layer.borderWidth = 0.6;
        seekButton.layer.borderColor = [UIColor colorWithWhite:0.0 alpha:0.2].CGColor;
        
        seekButton.userInteractionEnabled = NO;
        
        [self.view addSubview:seekButton];
        
        panVolumeArea = [[UIView alloc] initWithFrame:CGRectMake(20, 20, w - 40, progressBar.frame.origin.y - 50)];
        
//        panVolumeArea.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.1];
        
        [self.view addSubview:panVolumeArea];
        
        panWidth = 10.0;
        
        panVolumeButton = [[LPAPing alloc] initWithFrame:CGRectMake(CGRectGetMidX(panVolumeArea.frame) - panWidth / 2.0, CGRectGetMidY(panVolumeArea.frame) - panWidth / 2.0, panWidth, panWidth)];
        
        panVolumeButton.tintColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        panVolumeButton.backgroundColor = [UIColor colorWithWhite:0.3 alpha:1.0];
        
//        panVolumeButton.layer.borderColor = panVolumeButton.tintColor.CGColor;
//        panVolumeButton.layer.borderWidth = 1.0;
        panVolumeButton.layer.cornerRadius = panWidth / 2.0;
        
        [self.view addSubview:panVolumeButton];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,(unsigned long)NULL), ^{
            
            NSURL * url = [NSURL URLWithString:@"https://api.soundcloud.com/tracks/147445565/download?client_id=b45b1aa10f1ac2941910a7f0d10f8e28"];
            
            NSData * data = [NSData dataWithContentsOfURL:url];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                player = [[AVAudioPlayer alloc] initWithData:data error:nil];
                
                player.volume = volume;
                player.pan = pan;
                
//                NSLog(@"Pan %f",player.pan);
//                NSLog(@"Volume %f",player.volume);
                
                trackIsLoaded = YES;
                
                [activityIndicator stopAnimating];
                [activityIndicator removeFromSuperview];

                NSLog(@"player ready");
            });
            
        });
        
    }
    return self;
}

- (void)play
{
    if (!trackIsLoaded) return;
    
    if ([player isPlaying])
    {
        [player pause];
        
        [playButton setImage:[self getImageWithName:@"play"] forState:UIControlStateNormal];
        
        [timer invalidate];
        
    } else {
        
        [player play];
        
        [timer invalidate];
        timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
        
        [timer fire];
        
        [playButton setImage:[self getImageWithName:@"pause"] forState:UIControlStateNormal];
    }
}

- (void)stop
{
    [player stop];
    
    player.currentTime = 0;
    
    [self updateProgress];
    
    [playButton setImage:[self getImageWithName:@"play"] forState:UIControlStateNormal];
    
    [timer invalidate];
    timer = nil;
}

- (void)updateProgress
{
    float timePosition = player.currentTime / player.duration;
    float xPosition = timePosition * (progressBar.frame.size.width - 2);

//    NSLog(@"position %f",timePosition);
    
    playedBar.frame = CGRectMake(progressBar.frame.origin.x, progressBar.frame.origin.y, xPosition + 2, 2);
    seekButton.frame = CGRectMake(progressBar.frame.origin.x - 9 + xPosition, progressBar.frame.origin.y - 9, 20, 20);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self panVolumeWithTouches:touches];
    [self scrubBarWithTouches:touches];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self panVolumeWithTouches:touches];
    [self scrubBarWithTouches:touches];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint location = [[touches allObjects][0] locationInView:self.view];
    
    if(fabs(location.y - progressBar.frame.origin.y) > 10) return; // if not the scrub bar don't play
    
    if(![player isPlaying]) [self play];
}

- (void)panVolumeWithTouches:(NSSet *)touches
{
    CGPoint location = [[touches allObjects][0] locationInView:self.view];
    
    if (!CGRectContainsPoint(panVolumeArea.frame, location)) return;
    
    CGPoint locationInArea = [[touches allObjects][0] locationInView:panVolumeArea];
    
    player.pan = pan = locationInArea.x / (panVolumeArea.frame.size.width / 2.0) - 1.0;
    player.volume = volume = (panVolumeArea.frame.size.height - locationInArea.y) / panVolumeArea.frame.size.height;
    
    [UIView animateWithDuration:0.2 animations:^{
        panVolumeButton.frame = CGRectMake(location.x - panWidth / 2.0, location.y - panWidth / 2.0, panWidth, panWidth);
    }];
    
    
//    NSLog(@"Pan %f",player.pan);
//    NSLog(@"Volume %f",player.volume);
}

- (void)scrubBarWithTouches:(NSSet *)touches
{
    if (!trackIsLoaded) return;
    
    CGPoint location = [[touches allObjects][0] locationInView:self.view];
    
    if(fabs(location.y - progressBar.frame.origin.y) > 10) return;
    
//    NSLog(@"%d",abs(location.y - progressBar.frame.origin.y));
    
    if([player isPlaying]) [player pause];
    
    float xPosition = (location.x - progressBar.frame.origin.x) / progressBar.frame.size.width;
    
    if (xPosition > 1.0) xPosition = 1.0;
    if (xPosition < 0.0) xPosition = 0.0;
    
    player.currentTime = (int)(xPosition * player.duration);
    NSLog(@"Scrub %f",xPosition);
    
    [self updateProgress];
}



- (UIImage *)getImageWithName:(NSString *)buttonName
{
    UIGraphicsBeginImageContext(CGSizeMake(100, 100));
	CGContextRef context = UIGraphicsGetCurrentContext();
	
    CGContextSetLineWidth(context, 2.0);
    
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    [[UIColor colorWithWhite:0.0 alpha:0.5] set];
    
    if ([buttonName isEqualToString:@"stop"])
    {
        [RED_COLOR set];
        
//        CGContextStrokeRect(context, CGRectMake(30, 30, 40, 40));
    }
    
    if ([buttonName isEqualToString:@"play"])
    {
        [GREEN_COLOR set];
        
//        CGContextMoveToPoint(context, 33, 30);
//        CGContextAddLineToPoint(context, 73, 50);
//        CGContextAddLineToPoint(context, 33, 70);
//        CGContextAddLineToPoint(context, 33, 30);
//        
//        CGContextStrokePath(context);
    }
    
    if ([buttonName isEqualToString:@"pause"])
    {
//        [[UIColor whiteColor] set];
        
//        CGContextMoveToPoint(context, 35, 30);
//        CGContextAddLineToPoint(context, 35, 70);
//        
//        CGContextMoveToPoint(context, 65, 30);
//        CGContextAddLineToPoint(context, 65, 70);
//        
//        CGContextStrokePath(context);
    }

    CGContextFillEllipseInRect(context, CGRectMake(10, 10, 80, 80));

    CGContextStrokeEllipseInRect(context, CGRectMake(1, 1, 98, 98));
    
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

- (BOOL)prefersStatusBarHidden { return YES; }

@end
