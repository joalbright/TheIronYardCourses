//
//  SLFNewSelfyViewController.m
//  Selfy
//
//  Created by Jo Albright on 4/22/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "SLFNewSelfyViewController.h"

@interface SLFNewSelfyViewController () <UITextViewDelegate>

@end

@implementation SLFNewSelfyViewController
{
    UIView * newForm;
    UITextView * captionField;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        newForm = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 280, self.view.frame.size.height - 40)];
        
        [self.view addSubview:newForm];
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280, 280)];
        
        imageView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        
        [newForm addSubview:imageView];
        
        captionField = [[UITextView alloc] initWithFrame:CGRectMake(0, 300, 280, self.view.frame.size.height - 400)];
        
        captionField.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        captionField.delegate = self;
        captionField.keyboardType = UIKeyboardTypeTwitter;
        
        [newForm addSubview:captionField];
        
        
        UIButton * submitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, newForm.frame.size.height - 40, 280, 40)];
        submitButton.backgroundColor = [UIColor colorWithRed:0.137f green:0.627f blue:0.906f alpha:1.0f];
        submitButton.layer.cornerRadius = 6;
        
        [submitButton setTitle:@"New Selfy" forState:UIControlStateNormal];
        [submitButton addTarget:self action:@selector(newSelfy) forControlEvents:UIControlEventTouchUpInside];
        
        [newForm addSubview:submitButton];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen)];
        [self.view addGestureRecognizer:tap];
        
        // Custom initialization
    }
    return self;
}

- (void)tapScreen
{
    [captionField resignFirstResponder];
    [UIView animateWithDuration:0.2 animations:^{
        newForm.frame = CGRectMake(20, 20, 280, self.view.frame.size.height - 40);
//        newForm.frame = self.view.frame;
    }];
}

- (void)newSelfy
{
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.2 animations:^{
        newForm.frame = CGRectMake(20, 20 - KB_HEIGHT, 280, self.view.frame.size.height - 40);
    }];
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
