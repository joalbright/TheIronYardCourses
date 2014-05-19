//
//  PNAWorldData.m
//  PixelNoise
//
//  Created by Jo Albright on 5/6/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "PNAWorldData.h"

@implementation PNAWorldData

+ (PNAWorldData *)singleton
{
    static dispatch_once_t create;
    static PNAWorldData * singleton = nil;
    
    dispatch_once(&create, ^{
        singleton = [[PNAWorldData alloc] init];
    });
    
    return singleton;
}

@end
