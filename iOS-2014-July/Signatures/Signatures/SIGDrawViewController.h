//
//  SIGDrawViewController.h
//  Signatures
//
//  Created by Jo Albright on 8/14/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SIGDrawView;

@interface SIGDrawViewController : UIViewController

@property (nonatomic) SIGDrawView * drawView;

- (void)clearSignature;
- (UIImage *)getSignature;

@end
