//
//  GFATableViewCell.m
//  Github Friends
//
//  Created by Jo Albright on 7/24/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "GFATableViewCell.h"

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
    
        
        friendName = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 200, 40)];
        
        [self.contentView addSubview:friendName];
        
        friendImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        
        [self.contentView addSubview:friendImage];
    }
    return self;
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
