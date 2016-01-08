//
//  TLANavController.h
//  TweetLike
//
//  Created by Jo Albright on 4/23/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLATableViewController;

@interface TLANavController : UINavigationController

- (void)addTableViewController:(TLATableViewController *)viewController;

@end
