
//
//  DNASingleton.m
//  DataNow
//
//  Created by Jo Albright on 5/6/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "DNASingleton.h"

@implementation DNASingleton

+ (DNASingleton *)sharedSingleton
{
    static dispatch_once_t singletonBlock;
    static DNASingleton * singleton = nil;
    
    dispatch_once(&singletonBlock, ^{
        singleton = [[DNASingleton alloc] init];
    });
    
    return singleton;
}

//- (NSDictionary *)sectionInfo
//{
//    return @{
//             @"section1" : @[@"row1",@"row2"],
//             @"section2" : @[@"row1",@"row2",@"row3"]
//             };
//}

- (NSArray *)allRowsForSection:(NSString *)sectionName
{
    return self.sectionInfo[sectionName];
}

- (NSArray *)allSections
{
    return [self.sectionInfo allKeys];
}

@end


