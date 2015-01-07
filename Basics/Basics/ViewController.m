//
//  ViewController.m
//  Basics
//
//  Created by Jo Albright on 1/5/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

#import "ViewController.h"

//  Create 2 View Controllers on the main storyboard

//  View Controller 1
//  - 2 buttons (one will clear textfields, one will log all textfields)
//  - 3 textfields (username, email, password)
//  - password field should look like one by hiding the text with dots (look in the right panel)
//  - email field should use email keyboard (also in right panel)

//  View Controller 2
//  - 4 buttons with different color backgrounds
//  - each button changes the main view controller's background color

//  Add constraints
//  Make the buttons on view controller 2 circles with no text

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeBG:(id)sender {
    
    UIButton * button = (UIButton *)sender;
    self.view.backgroundColor = button.backgroundColor;
    
}

- (IBAction)clearFields:(id)sender {
    
    self.usernameField.text = @"";
    self.emailField.text = @"";
    self.passwordField.text = @"";
    
}

- (IBAction)logFields:(id)sender {
    
    NSLog(@"%@",self.usernameField.text);
    NSLog(@"%@",self.emailField.text);
    NSLog(@"%@",self.passwordField.text);
    
}

@end






