//
//  MSARequest.m
//  Mayorships
//
//  Created by Jo Albright on 8/19/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "MSARequest.h"

#define API @"https://api.foursquare.com/v2/"
#define CLIENT_ID @"2MJ4R0XEU4WQ1YUPUUHTS5FJFZL3A1H4PR1Z2BPI1AHUEHOE"
#define CLIENT_SECRET @"J1SLYGGM4YDU11HUXVA4H0ECU2YZFUDJ0UK2MST502ZGENZZ"

// api.foursquare.com/v2/venues/search?client_id=CLIENT_ID&client_secret=CLIENT_SECRET&v=YYYYMMDD&ll=40.7,-74"

@implementation MSARequest

//+ (NSArray *)findMayorshipsWithLocation:(CLLocation *)location
+ (void)findMayorshipsWithLocation:(CLLocation *)location completion:(void (^)(NSArray * mayors))completion
{
//    NSArray * venues = [MSARequest findVenuesWithLocation:location];
    
    [MSARequest findVenuesWithLocation:location completion:^(NSArray *venues) {
       
        NSMutableArray * mayors = [@[] mutableCopy];
        
        for (NSDictionary * venue in venues)
        {
            NSString * endpoint = [NSString stringWithFormat:@"venues/%@",venue[@"id"]];
            
            //        NSDictionary * venueInfo = [MSARequest foursquareRequestWithEndpoint:endpoint andParameters:@{}];
            
            [MSARequest foursquareRequestWithEndpoint:endpoint andParameters:@{} completion:^(NSDictionary *responseInfo) {
                
                NSDictionary * mayor = responseInfo[@"response"][@"venue"][@"mayor"];
                
                if(mayor) [mayors addObject:mayor];
                
                if(completion) completion(mayors);
                
            }];
            
            // https://api.foursquare.com/v2/venues/VENUE_ID
        }
        
        //    return mayors;
        
    }];
    
}

+ (void)findMayorshipsWithLocation:(CLLocation *)location completion:(void (^)(NSArray * mayors))completion
{
    //    NSArray * venues = [MSARequest findVenuesWithLocation:location];
    
    [MSARequest findVenuesWithLocation:location completion:^(NSArray *venues) {
        
        NSMutableArray * mayors = [@[] mutableCopy];
        
        for (NSDictionary * venue in venues)
        {
            NSString * endpoint = [NSString stringWithFormat:@"venues/%@",venue[@"id"]];
            
            //        NSDictionary * venueInfo = [MSARequest foursquareRequestWithEndpoint:endpoint andParameters:@{}];
            
            [MSARequest foursquareRequestWithEndpoint:endpoint andParameters:@{} completion:^(NSDictionary *responseInfo) {
                
                NSDictionary * mayor = responseInfo[@"response"][@"venue"][@"mayor"];
                
                if(mayor) [mayors addObject:mayor];
                
                if(completion) completion(mayors);
                
            }];
            
            // https://api.foursquare.com/v2/venues/VENUE_ID
        }
        
        //    return mayors;
        
    }];
    
}

+ (void)foursquareRequestWithEndpoint:(NSString *)endpoint andParameters:(NSDictionary *)parameters completion:(void(^)(NSDictionary * responseInfo))completion
{
    NSMutableString * requestString = [[API stringByAppendingString:endpoint] mutableCopy];
    
    // make v custom to current day
    
    [requestString appendString:[NSString stringWithFormat:@"?client_id=%@&client_secret=%@&v=20140819",CLIENT_ID,CLIENT_SECRET]];

    for (NSString * key in [parameters allKeys])
    {
        [requestString appendFormat:@"&%@=%@", key, [parameters objectForKey:key]];
    }
    
    NSLog(@"%@",requestString);
    
    NSURL * requestURL = [NSURL URLWithString:requestString];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:requestURL];
    
//    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData * data, NSError *connectionError) {
       
        NSDictionary * responseInfo = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        if(completion) completion(responseInfo);
        
    }];
    
//    NSLog(@"%@",responseInfo);
    
//    return responseInfo;
}

@end
