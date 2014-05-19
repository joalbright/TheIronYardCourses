//
//  RVBData.m
//  RedvsBlue
//
//  Created by Jo Albright on 5/7/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "RVBData.h"

@implementation RVBData

+ (RVBData *)mainData
{
    static dispatch_once_t create;
    static RVBData * mainData = nil;
    
    dispatch_once(&create, ^{
        mainData = [[RVBData alloc] init];
    });
    
    return mainData;
}

- (NSInteger)totalScore
{
    return _redScore + _blueScore;
}

@end
