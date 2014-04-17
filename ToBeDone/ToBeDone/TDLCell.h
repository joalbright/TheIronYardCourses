//
//  TDLCell.h
//  ToBeDone
//
//  Created by Jo Albright on 4/9/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TDLCellDelegate;

@interface TDLCell : UITableViewCell

@property (nonatomic,assign) id<TDLCellDelegate> delegate;

@property (nonatomic) UILabel * nameLabel;
@property (nonatomic) UIView * bgView;
@property (nonatomic) UIView * strikeThrough;
@property (nonatomic) UIButton * circleButton;

@property (nonatomic) BOOL swiped;

- (void)resetLayout;

- (void)showCircleButtons;
- (void)hideCircleButtons;

- (void)showDeleteButton;
- (void)hideDeleteButton;

@end

@protocol TDLCellDelegate <NSObject>

- (void)deleteItem:(TDLCell *)cell;
- (void)setItemPriority:(int)priority withItem:(TDLCell *)cell;

@optional

- (void)optionalMethod;

@end
