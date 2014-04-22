//
//  BBALevelData.h
//  BrickBreaker
//
//  Created by Jo Albright on 4/20/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBALevelData : NSObject

+ (BBALevelData *)dataCollection;

@property (nonatomic,readonly) NSArray * levelmaps;
@property (nonatomic,readonly) NSArray * games;

- (NSMutableDictionary *)newGame;

@end
