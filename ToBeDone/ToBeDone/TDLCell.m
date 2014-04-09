//
//  TDLCell.m
//  ToBeDone
//
//  Created by Jo Albright on 4/9/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "TDLCell.h"

@implementation TDLCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, 40)];
        self.bgView.layer.cornerRadius = 6;
        
        [self.contentView addSubview:self.bgView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 200, 30)];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:26];
        
        [self.contentView addSubview:self.nameLabel];
         
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

@end
