//
//  PNAPixelSounds.h
//  PixelNoise
//
//  Created by Jo Albright on 5/4/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface PNAPixelSounds : NSObject <AVAudioPlayerDelegate>

@property (nonatomic) AVAudioPlayer * player;
@property (nonatomic) NSMutableArray * players;

- (void)playSoundWithName:(NSString *)soundName;

@end
