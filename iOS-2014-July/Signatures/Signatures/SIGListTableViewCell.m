//
//  SIGListTableViewCell.m
//  Signatures
//
//  Created by Jo Albright on 8/14/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "SIGListTableViewCell.h"

@implementation SIGListTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.signatureView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        
        [self.contentView addSubview:self.signatureView];
        
        // Initialization code
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
