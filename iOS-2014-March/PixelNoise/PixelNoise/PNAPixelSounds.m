//
//  PNAPixelSounds.m
//  PixelNoise
//
//  Created by Jo Albright on 5/4/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "PNAPixelSounds.h"

@implementation PNAPixelSounds

- (id)init
{
    self = [super init];
    if(self)
    {
        self.players = [@[] mutableCopy];
    }
    return self;
}

- (void)playSoundWithName:(NSString *)soundName
{
    NSString * file = [[NSBundle mainBundle] pathForResource:soundName ofType:@"wav"];
    
    NSData *fileData = [NSData dataWithContentsOfFile:file];
    
    AVAudioPlayer * player = [[AVAudioPlayer alloc] initWithData:fileData error:nil];
    
    player.delegate = self;
    
    [self.players addObject:player];
    
    
    [player play];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self.players removeObjectIdenticalTo:player];
    NSLog(@"players %d",(int)[self.players count]);
}

@end
