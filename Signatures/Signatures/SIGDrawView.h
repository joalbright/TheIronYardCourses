//
//  SIGDrawView.h
//  Signatures
//
//  Created by Jo Albright on 8/14/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SIGDrawView : UIView

@property (nonatomic) NSMutableArray * scribbles;
@property (nonatomic) NSMutableArray * currentScribble;

@property (nonatomic) UIImage * scribblesImage;

@end
