//
//  TLANavController.m
//  TweetLike
//
//  Created by Jo Albright on 4/23/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "TLANavController.h"

#import "TLATableViewController.h"

@interface TLANavController () <UITextViewDelegate>

@end

@implementation TLANavController
{
    UIButton * addNewItem;
    
    UIView * blueBox;
    UIView * newForm;
    
    UIImageView * logo;
    
    UITextView * captionView;
    
    TLATableViewController * TVC;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ///////////////
    
    blueBox = [[UIView alloc] initWithFrame:self.navigationBar.frame];
    blueBox.backgroundColor = [UIColor colorWithRed:0.216f green:0.533f blue:0.984f alpha:1.0f];
    
    [self.view addSubview:blueBox];
    
    
    newForm = [[UIView alloc] initWithFrame:self.view.frame];
//    [blueBox addSubview:newForm];
    
    ///////////////
    
    addNewItem = [[UIButton alloc] initWithFrame:CGRectMake(80, (self.navigationBar.frame.size.height - 30) / 2, 160, 30)];
    addNewItem.backgroundColor = [UIColor whiteColor];
    addNewItem.layer.cornerRadius = 15;
    
    [addNewItem setTitle:@"Add New" forState:UIControlStateNormal];
    [addNewItem setTitleColor:[UIColor colorWithRed:0.216f green:0.533f blue:0.984f alpha:1.0f] forState:UIControlStateNormal];
    
    [addNewItem addTarget:self action:@selector(newItem:) forControlEvents:UIControlEventTouchUpInside];
    
    [blueBox addSubview:addNewItem];
    
    ////////////////
    
    
    logo = [[UIImageView alloc] initWithFrame:CGRectMake(160 - 87.5, 200, 175, 45)];
    
    logo.image = [UIImage imageNamed:@"logo"];
    
    [newForm addSubview:logo];
    
    
    captionView = [[UITextView alloc] initWithFrame:CGRectMake(40, (self.view.frame.size.height - 80) / 2, 240, 80)];
    captionView.layer.cornerRadius = 10;
    captionView.delegate = self;
    
    [newForm addSubview:captionView];
    
    
    float captionBottom = captionView.frame.size.height + captionView.frame.origin.y;
    
    UIButton * submitTweetButton = [[UIButton alloc] initWithFrame:CGRectMake(40, captionBottom + 20, 100, 40)];
    submitTweetButton.backgroundColor = [UIColor greenColor];
    submitTweetButton.layer.cornerRadius = submitTweetButton.frame.size.height / 2;
    
    [submitTweetButton setTitle:@"Submit" forState:UIControlStateNormal];
    [submitTweetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitTweetButton addTarget:self action:@selector(saveTweet) forControlEvents:UIControlEventTouchUpInside];
    
    [newForm addSubview:submitTweetButton];
    
    UIButton * cancelButton = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 140, captionBottom + 20, 100, 40)];
    cancelButton.backgroundColor = [UIColor redColor];
    cancelButton.layer.cornerRadius = submitTweetButton.frame.size.height / 2;
    
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelTweet) forControlEvents:UIControlEventTouchUpInside];
    
    [newForm addSubview:cancelButton];
    
}

- (void)cancelTweet
{
    [newForm removeFromSuperview];
    newForm.frame = self.view.frame;
    [UIView animateWithDuration:0.4 animations:^{
        
        blueBox.frame = self.navigationBar.frame;
        addNewItem.alpha = 1.0;
        
    }];
}

- (void)saveTweet
{
    if ([captionView.text isEqualToString:@""]) return;
    
//    [TVC.tweetItems insertObject:@{
//                                   @"likes":@0,
//                                   @"text": captionView.text
//                                   } atIndex:0];
//    
//    [TVC.tableView reloadData];
    
    [TVC createNewTweet:captionView.text];
        
    captionView.text = @"";
    
    [self cancelTweet];
}

- (void)newItem:(UIButton *)sender
{
    [UIView animateWithDuration:0.4 animations:^{

        blueBox.frame = self.view.frame;
        sender.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [blueBox addSubview:newForm];
    }];
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.4 animations:^{
        
        newForm.frame = CGRectMake(0, -216 / 2, self.view.frame.size.width, self.view.frame.size.height);
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addTableViewController:(TLATableViewController *)viewController
{
    TVC = viewController;
    
    [self pushViewController:viewController animated:NO];
    
    if ([TVC isTweetItemsEmpty])
    {
        [self newItem:addNewItem];
        
        [addNewItem addTarget:self action:@selector(newItem:) forControlEvents:UIControlEventTouchUpInside];

    }
    
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
//- (BOOL)prefersStatusBarHidden
//{
//    return  YES;
//}

@end
