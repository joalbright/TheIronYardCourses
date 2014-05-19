//
//  HSBFilter.h
//  HueSaturationBrightness
//
//  Created by Jisha Obukwelu on 5/2/14.
//  Copyright (c) 2014 Jisha Obukwelu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HSBColorControlVCDelegate;

@interface HSBColorControlVC : UIViewController

@property (nonatomic) UIImage* currentImage;

@property (nonatomic) id <HSBColorControlVCDelegate> delegate;

@end

@protocol HSBColorControlVCDelegate <NSObject>;

- (void)updateCurrentImageWithHSB: (UIImage * )image;

@end
