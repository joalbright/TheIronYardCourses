//
//  RVBRedViewController.h
//  RedvsBlue
//
//  Created by Jo Albright on 5/7/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RVBColorViewDelegate;

@interface RVBRedViewController : UIViewController

@property (nonatomic,assign) id<RVBColorViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame andColor:(UIColor *)color;

@end

@protocol RVBColorViewDelegate <NSObject>

- (void)updateScore;

@end