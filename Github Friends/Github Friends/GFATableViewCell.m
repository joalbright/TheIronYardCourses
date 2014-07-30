//
//  GFATableViewCell.m
//  Github Friends
//
//  Created by Jo Albright on 7/24/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "GFATableViewCell.h"

#import "GFAViewController.h"

@implementation GFATableViewCell
{
    UILabel * friendName;
    UIImageView * friendImage;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor colorWithRed:0.227f green:0.227f blue:0.227f alpha:1.0f];
        
        friendName = [[UILabel alloc] initWithFrame:CGRectMake(110, 10, 200, 40)];
        friendName.textColor = [UIColor whiteColor];
        
        [self.contentView addSubview:friendName];
        
        friendImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        
        [self.contentView addSubview:friendImage];
        
        UIButton * profileButton = [[UIButton alloc] initWithFrame:CGRectMake(280, 10, 30, 30)];
        
        [profileButton setBackgroundImage:[UIImage imageNamed:@"profileArrow"] forState:UIControlStateNormal];
                
        [profileButton addTarget:self action:@selector(profileButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:profileButton];
        
        UIButton * gistButton = [[UIButton alloc] initWithFrame:CGRectMake(260, 50, 40, 40)];
        
        gistButton.backgroundColor = [UIColor whiteColor];
        
        [gistButton addTarget:self action:@selector(gistButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:gistButton];
    }
    return self;
}

- (void)profileButtonClicked
{
    GFAViewController * profileView = [[GFAViewController alloc] init];
    
    profileView.view.backgroundColor = [UIColor lightGrayColor];
    
    // only this line changed
    profileView.friendInfo = self.friendInfo;
    
    [self.navigationController pushViewController:profileView animated:YES];
}

- (void)gistButtonClicked
{
    GFAViewController * profileView = [[GFAViewController alloc] init];
    
    profileView.view.backgroundColor = [UIColor lightGrayColor];
    
    // https://gist.github.com/joalbright
    
    NSString * gistURL = [NSString stringWithFormat:@"https://gist.github.com/%@",self.friendInfo[@"login"]];
    
    profileView.friendInfo = @{@"html_url":gistURL};
    
    [self.navigationController pushViewController:profileView animated:YES];
}

//    @"login" : @"joalbright",
//    @"avatar_url" : @"https://avatars.githubusercontent.com/u/1536630?",
//    @"name" : @"Jo Albright",
//    @"blog" : @"jo2.co",
//    @"location" : @"Atlanta, Ga",
//    @"email" : @"me@jo2.co"

- (void)setFriendInfo:(NSDictionary *)friendInfo
{
    _friendInfo = friendInfo;
    
    
    
    
    NSURL * url = [NSURL URLWithString:friendInfo[@"avatar_url"]];
    
    NSData * data = [NSData dataWithContentsOfURL:url];
    
    UIImage * image = [UIImage imageWithData:data];

    friendImage.image = image;
    
    friendName.text = friendInfo[@"name"];
    
    NSLog(@"%@",friendInfo);
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
