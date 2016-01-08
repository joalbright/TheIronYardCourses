//
//  CARWheel.h
//  Car
//
//  Created by Jo Albright on 4/1/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CARWheel : UIView

@property (nonatomic) int tirePressure;
@property (nonatomic) BOOL flat;

- (void)fillWithAir;

@end
