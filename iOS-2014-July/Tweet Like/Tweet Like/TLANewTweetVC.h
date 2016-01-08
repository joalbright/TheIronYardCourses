//
//  TLANewTweetVC.h
//  Tweet Like
//
//  Created by Jo Albright on 8/11/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLANewTweetVC : UIViewController

@property (nonatomic) NSMutableArray * tweets;

@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (weak, nonatomic) IBOutlet UIImageView *swipeButton;
@property (weak, nonatomic) IBOutlet UIView *greenCircle;
@property (weak, nonatomic) IBOutlet UIView *redCircle;

@end
