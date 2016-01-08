//
//  MFCRootViewController.m
//  My First Code App
//
//  Created by Jo Albright on 7/22/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "MFCRootViewController.h"

@interface MFCRootViewController () <UITextFieldDelegate>

// declare private properties & methods

//@property (nonatomic) UILabel * someLabel;

@end

@implementation MFCRootViewController
{
    UILabel * someLabel;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        NSLog(@"init");
        
        self.view.backgroundColor = [UIColor colorWithRed:0.569f green:1.000f blue:0.969f alpha:1.0f];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    int screenHeight = [UIScreen mainScreen].bounds.size.height;
    int screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    UIButton * loginButton = [[UIButton alloc] initWithFrame:CGRectMake(10.0, screenHeight - 60.0, screenWidth - 20.0, 50.0)];
    
    [loginButton setTitle:@"Login" forState:UIControlStateNormal];
    loginButton.backgroundColor = [UIColor blueColor];
    
    loginButton.layer.cornerRadius = 10.0;
    
//    [self loginButtonClicked];
    
    [loginButton addTarget:self action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:loginButton];
    
    
    UITextField * usernameField = [[UITextField alloc] initWithFrame:CGRectMake(10.0, 30.0, screenWidth - 20.0, 50.0)];
    
    usernameField.backgroundColor = [UIColor whiteColor];
    
    usernameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    usernameField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    usernameField.placeholder = @"username";
    
    usernameField.delegate = self;
    
//    usernameField.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:usernameField];
    
    NSLog(@"view did load");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    NSLog(@"text field should return");
    [textField resignFirstResponder];
    
    return YES;
}

- (void)loginButtonClicked
{
    NSLog(@"button was clicked");
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
