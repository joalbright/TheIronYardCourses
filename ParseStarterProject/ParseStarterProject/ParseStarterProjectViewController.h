//
//  ParseStarterProjectViewController.h
//  ParseStarterProject
//
//  Copyright 2014 Parse, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParseStarterProjectViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *messageField;

- (IBAction)sendMessage:(id)sender;

@end
