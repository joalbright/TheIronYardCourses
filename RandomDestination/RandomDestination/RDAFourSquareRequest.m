//
//  RDAFourSquareRequest.m
//  RandomDestination
//
//  Created by Jo Albright on 6/5/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "RDAFourSquareRequest.h"

@implementation RDAFourSquareRequest


+ (NSArray *)getVenuesWithLat:(double)latitude andLong:(double)longitude
{
    NSArray * venues = @[];
    
    NSString * locationURL = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/explore?ll=%f,%f&oauth_token=ALU5R2QUMJMVUXZST5TVDCKJOJQC44YJOG0JKWXHP2CY21QH&v=20140605",latitude,longitude];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:locationURL]];
    
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary * fsInfo = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
    
    venues = fsInfo[@"response"][@"groups"][0][@"items"];
    
    return venues;
}

@end
