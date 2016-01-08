//
//  RDAFourSquareRequest.h
//  RandomDestination
//
//  Created by Jo Albright on 6/5/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RDAFourSquareRequest : NSObject

+ (NSArray *)getVenuesWithLat:(double)latitude andLong:(double)longitude;

@end
