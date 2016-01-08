//
//  BBALevelData.m
//  BrickBreaker
//
//  Created by Jo Albright on 4/20/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "BBALevelData.h"

@interface BBALevelData ()

@property (nonatomic) NSArray * customLevels; // allows users to create their own

@end

@implementation BBALevelData
{
    NSMutableArray * allgames;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self dataCollection];
}

+ (BBALevelData *)dataCollection
{
    static BBALevelData * dataCollection = nil;
    if (!dataCollection)
    {
        dataCollection = [[super allocWithZone:NULL] init];
    }
    return dataCollection;
}

- (NSArray *)levelmaps
{
    NSMutableArray * combinedLevels = [[self originalLevels] mutableCopy];
    
    return combinedLevels;
}

- (NSArray *)games
{
    if(allgames == nil)
        allgames = [@[
                      [@{
                      @"score":@0,
                      @"levels":[@[
                                   [@{
                                      @"score":@0,
                                      @"level":@(0),
                                      @"paddle_hits":@0,
                                      @"bricks_broken":@0,
                                      @"lives_lost":@0,
                                      @"wall_hits":[@{
                                                      @"ceiling":@0,
                                                      @"left":@0,
                                                      @"right":@0
                                                      } mutableCopy]
                                      } mutableCopy]
                                   ] mutableCopy]
                      } mutableCopy]
                    ] mutableCopy];
    
    return allgames;
}

- (NSArray *)originalLevels
{
    return @[
             
             @[
                 @[@2,@2,@2,@2],
                 @[@1,@2,@2,@2,@2,@1],
                 @[@0,@1,@1,@2,@2,@1,@1,@0],
                 @[@1,@1,@2,@2,@1,@1],
                 @[@1,@1,@1,@1]
                 ],
             
        @[
            @[@1,@1,@1,@1,@1,@1],
            @[@1,@1,@1,@1,@1,@1]
        ],
        
        @[
            @[@1,@1,@1,@1,@1,@1],
            @[@1,@1,@0,@0,@1,@1],
            @[@1,@1,@1,@1,@1,@1]
        ],
        
        @[
            @[@2,@2,@2,@2],
            @[@1,@1,@1,@1,@1,@1],
            @[@1,@1,@1,@1,@1,@1]
        ],
        
        @[
            @[@1,@2,@2,@2,@2,@1],
            @[@1,@1,@2,@2,@1,@1],
            @[@0,@1,@1,@1,@1,@0],
            @[@0,@0,@1,@1,@0,@0]
        ],

        @[
            @[@0,@1,@2,@2,@1,@0],
            @[@1,@1,@2,@2,@1,@1],
            @[@1,@1,@2,@2,@1,@1],
            @[@0,@1,@2,@2,@1,@0]
        ],
        
        @[
            @[@1,@2,@2,@2,@2,@1],
            @[@1,@2,@0,@0,@2,@1],
            @[@1,@1,@0,@0,@1,@1],
            @[@0,@1,@1,@1,@1,@0]
        ],
        
        @[
            @[@2,@2,@2,@2],
            @[@1,@2,@2,@2,@2,@1],
            @[@0,@1,@1,@2,@2,@1,@1,@0],
            @[@1,@1,@2,@2,@1,@1],
            @[@1,@1,@1,@1]
        ]

    ];
}

- (NSMutableDictionary *)newGame
{
    if(allgames == nil) allgames = [@[] mutableCopy];
    
    NSMutableDictionary * game = [@{
                               
                               @"score" : @0,
                               @"levels" : [@[] mutableCopy]
                               
                               } mutableCopy];
    
    [allgames addObject:game];
    
    return game;
}

@end
