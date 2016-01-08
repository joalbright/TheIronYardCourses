//
//  TLANewTweetVC.m
//  Tweet Like
//
//  Created by Jo Albright on 8/11/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "TLANewTweetVC.h"

#import <Parse/Parse.h>

@interface TLANewTweetVC () <UITextViewDelegate>

@end

@implementation TLANewTweetVC
{
    CGPoint swipeButtonOrigin;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tweetTextView.layer.cornerRadius = 10;
    self.tweetTextView.delegate = self;
    
    self.greenCircle.layer.cornerRadius = 90;
    self.redCircle.layer.cornerRadius = 90;
    
    swipeButtonOrigin = self.swipeButton.center;
    
    // Do any additional setup after loading the view.
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
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

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches allObjects][0];
    
    self.swipeButton.center = [touch locationInView:self.view];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches allObjects][0];
    
    BOOL isOnRed = [self isPoint:[touch locationInView:self.view] withInRadius:self.redCircle.frame.size.width / 2.0 ofPoint:self.redCircle.center];
    
    BOOL isOnGreen = [self isPoint:[touch locationInView:self.view] withInRadius:self.greenCircle.frame.size.width / 2.0 ofPoint:self.greenCircle.center];
    
    if (isOnRed)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else if (isOnGreen) {
        
        PFObject * newTweetLike = [PFObject objectWithClassName:@"Tweet"];
        
        [newTweetLike setObject:@0 forKey:@"hearts"];
        [newTweetLike setObject:self.tweetTextView.text forKey:@"text"];
        [newTweetLike setObject:@(arc4random_uniform(100000000)) forKey:@"id"];
        
        [self.tweets insertObject:newTweetLike atIndex:0];
        
        [newTweetLike saveInBackground];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else {
        
        [UIView animateWithDuration:0.2 animations:^{
            
            self.swipeButton.center = swipeButtonOrigin;
            
        }];
    }
    
}

- (BOOL)isPoint:(CGPoint)point withInRadius:(int)radius ofPoint:(CGPoint)center
{
    CGFloat dx = center.x - point.x;
    CGFloat dy = center.y - point.y;
    CGFloat distance = sqrt(dx * dx + dy * dy);
    return (distance < radius);
}

@end
