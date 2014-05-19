//
//  PEAScrollController.h
//  Photo Editor
//
//  Created by Jo Albright on 4/30/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PEAFilterControllerDelegate;

@interface PEAFilterController : UIViewController

@property (nonatomic,assign) id<PEAFilterControllerDelegate> delegate;

@property (nonatomic) UIImage * imageToFilter;

@end

@protocol PEAFilterControllerDelegate <NSObject>

- (void)updateCurrentImageWithFilteredImage:(UIImage *)image;

@end
