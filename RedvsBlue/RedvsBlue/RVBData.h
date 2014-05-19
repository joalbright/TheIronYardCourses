//
//  RVBData.h
//  RedvsBlue
//
//  Created by Jo Albright on 5/7/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RVBData : NSObject

+ (RVBData *)mainData;

@property (nonatomic) NSInteger redScore;
@property (nonatomic) NSInteger blueScore;
@property (nonatomic,readonly) NSInteger totalScore;

@end
