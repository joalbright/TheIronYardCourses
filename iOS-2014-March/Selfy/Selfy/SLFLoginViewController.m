//
//  SLFLoginViewController.m
//  Selfy
//
//  Created by Jo Albright on 4/22/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "SLFLoginViewController.h"

#import <Parse/Parse.h>

@interface SLFLoginViewController () <UITextFieldDelegate>

@end

@implementation SLFLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        UIView * loginForm = [[UIView alloc] initWithFrame:CGRectMake(20, (self.view.frame.size.height - 140) / 2, 280, 140)];
        
        [self.view addSubview:loginForm];
        
        UITextField * loginField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 280, 40)];
        loginField.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        loginField.layer.cornerRadius = 6;
        loginField.placeholder = @"Username";
        loginField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
        loginField.leftViewMode = UITextFieldViewModeAlways;
        loginField.delegate = self;
        
        [loginForm addSubview:loginField];
        
        
        UITextField * passwordField = [[UITextField alloc] initWithFrame:CGRectMake(0, 50, 280, 40)];
        passwordField.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        passwordField.layer.cornerRadius = 6;
        passwordField.placeholder = @"Password";
        passwordField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
        passwordField.leftViewMode = UITextFieldViewModeAlways;
        passwordField.delegate = self;
        passwordField.secureTextEntry = YES;
        
        [loginForm addSubview:passwordField];
        
        UIButton * submitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 280, 40)];
        submitButton.backgroundColor = [UIColor colorWithRed:0.137f green:0.627f blue:0.906f alpha:1.0f];
        submitButton.layer.cornerRadius = 6;
        
        [submitButton setTitle:@"Sign In" forState:UIControlStateNormal];
        [submitButton addTarget:self action:@selector(signIn) forControlEvents:UIControlEventTouchUpInside];
        
        [loginForm addSubview:submitButton];
        
        // Custom initialization
    }
    return self;
}

- (void)signIn
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
