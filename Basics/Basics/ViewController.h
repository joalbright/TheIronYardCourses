//
//  ViewController.h
//  Basics
//
//  Created by Jo Albright on 1/5/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;


- (IBAction)changeBG:(id)sender;


- (IBAction)clearFields:(id)sender;
- (IBAction)logFields:(id)sender;

@end






