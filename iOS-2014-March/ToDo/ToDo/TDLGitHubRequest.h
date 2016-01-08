//
//  TDLGitHubRequest.h
//  ToDo
//
//  Created by Jo Albright on 4/7/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDLGitHubRequest : NSObject

+ (NSDictionary *)getUserWithUsername:(NSString *)username;

@end
