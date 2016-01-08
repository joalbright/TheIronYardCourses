//
//  DLAStageScribble.h
//  DrawLinesApp
//
//  Created by Jo Albright on 4/15/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLAStageScribble : UIView

@property (nonatomic) float lineWidth;
@property (nonatomic) UIColor * lineColor;
@property (nonatomic) NSMutableArray * lines;

- (void)clearStage;
- (void)undoStage;

@end
