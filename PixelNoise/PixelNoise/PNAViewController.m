//
//  PNAViewController.m
//  PixelNoise
//
//  Created by Jo Albright on 5/4/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "PNAViewController.h"
#import "PNAPixelSounds.h"

#import "PNAPixelWorldController.h"


@interface PNAViewController ()

@end

@implementation PNAViewController
{
    PNAPixelSounds * sounds;
    PNAPixelWorldController * world;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        sounds = [[PNAPixelSounds alloc] init];
        world = [[PNAPixelWorldController alloc] initWithNibName:nil bundle:nil];
        
        [self.view addSubview:world.view];
    }
    return self;
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

- (BOOL)prefersStatusBarHidden { return YES; }


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Play Sound");
//    [sounds playSoundWithName:@"click_alert"];
}

@end
