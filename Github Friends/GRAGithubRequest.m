//
//  GRAGithubRequest.m
//  Github Request
//
//  Created by Jo Albright on 7/28/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "GRAGithubRequest.h"

@implementation GRAGithubRequest

+ (NSDictionary *)requestUserInfo:(NSString *)username
{
    // take the username and call the github url
    
    NSString * urlString = [NSString stringWithFormat:@"https://api.github.com/users/%@?access_token=0da19408847b8e87733cefe19625e766a00e68f2",username];
    
    NSURL * url = [NSURL URLWithString:urlString];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    ///////// mutable request
    
    NSMutableURLRequest * mutableRequest = [NSMutableURLRequest requestWithURL:url];
    
    [mutableRequest setHTTPMethod:@"POST"];
    
    /////////
    
    NSURLResponse * response = nil;
    NSError * error = nil;
    
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSDictionary * userInfo = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    
    NSLog(@"user info = %@",userInfo);
    
    return userInfo;
}

+ (void)saveUsers:(NSArray *)users
{
    // path to what we are saving
    NSString * path = [GRAGithubRequest usersArchivePath];
    
    // then we archive
    NSData * userData = [NSKeyedArchiver archivedDataWithRootObject:users];

    // then we save file
    [userData writeToFile:path options:NSDataWritingAtomic error:nil];
}

+ (NSArray *)loadUsers
{
    // path to what we are loading
    NSString * path = [GRAGithubRequest usersArchivePath];
    
    // then we unarchive
    NSArray * users = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    // then we return the array
    return users;
}

+ (NSString *)usersArchivePath
{
    // returns array of directories
    NSArray * documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

    // grab first path from above array
    NSString * documentDirectory = documentDirectories[0];
    
    // return path/users.data
    return [documentDirectory stringByAppendingPathComponent:@"users.data"];
}

@end
