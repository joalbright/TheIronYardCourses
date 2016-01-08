//
//  LoginViewController.m
//  Camera
//
//  Created by Jo Albright on 10/19/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

#import "LoginViewController.h"

#import <Parse/Parse.h>

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField * usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField * passwordTextField;


@end

@implementation LoginViewController

- (IBAction)login:(id)sender {
    
    [PFUser logInWithUsernameInBackground:self.usernameTextField.text password:self.passwordTextField.text block:^(PFUser * _Nullable user, NSError * _Nullable error) {
        
        if (user != nil) {
            
            NSLog(@"logged in");
            
        }
        
    }];
    
}

@end
