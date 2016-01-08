//
//  ParseStarterProjectViewController.m
//  ParseStarterProject
//
//  Copyright 2014 Parse, Inc. All rights reserved.
//

#import "ParseStarterProjectViewController.h"

#import <Parse/Parse.h>

@implementation ParseStarterProjectViewController

#pragma mark - UIViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)sendMessage:(id)sender {
    
    PFQuery * userQuery = [PFUser query];
    [userQuery whereKey:@"username" notEqualTo:[PFUser currentUser][@"username"]];
    
    PFQuery * deviceQuery = [PFInstallation query];
    [deviceQuery whereKey:@"user" matchesQuery:userQuery];
    
    PFPush * pushMessage = [PFPush push];
    [pushMessage setQuery:deviceQuery];
    [pushMessage setMessage:self.messageField.text];
    [pushMessage sendPushInBackground];
    
}
@end
