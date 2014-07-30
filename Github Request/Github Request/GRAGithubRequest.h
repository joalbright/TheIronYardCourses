//
//  GRAGithubRequest.h
//  Github Request
//
//  Created by Jo Albright on 7/28/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRAGithubRequest : NSObject

+ (NSDictionary *)requestUserInfo:(NSString *)username;

@end
