//
//  SLFTableViewCell.m
//  Selfy
//
//  Created by Jo Albright on 4/22/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "SLFTableViewCell.h"

@implementation SLFTableViewCell
{
    UIImageView * selfyView;
    UIImageView * avatarView;
    UILabel * selfyCaption;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        /// selfy image view
        selfyView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 280, 280)];
        selfyView.backgroundColor = [UIColor lightGrayColor];
        
        [self.contentView addSubview:selfyView];
        
        /// avatar image view
        avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 320, 40, 40)];
        avatarView.backgroundColor = [UIColor lightGrayColor];
        avatarView.layer.cornerRadius = 20;
        avatarView.layer.masksToBounds = YES;
        [self.contentView addSubview:avatarView];
        
        
        // selfy caption
        selfyCaption = [[UILabel alloc] initWithFrame: CGRectMake(80, 320, 220, 40)];
        
        selfyCaption.textColor = [UIColor darkGrayColor];
        selfyCaption.text = @"Hello";
        [self.contentView addSubview:selfyCaption];
    }
    return self;
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

- (void)setSelfyInfo:(NSDictionary *)selfyInfo
{
    _selfyInfo = selfyInfo;
    
    
    selfyCaption.text = selfyInfo[@"caption"];
    
    NSURL * imageURL = [NSURL URLWithString:selfyInfo[@"image"]];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];
    
    selfyView.image = image;
    
    NSURL * avatarURL = [NSURL URLWithString:selfyInfo[@"avatar"]];
    NSData * avatarData = [NSData dataWithContentsOfURL:avatarURL];
    UIImage * avatar = [UIImage imageWithData:avatarData];
    
    avatarView.image = avatar;
}

@end
