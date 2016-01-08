//
//  PEASuperFilter.h
//  Photo Editor
//
//  Created by Jo Albright on 5/2/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import <CoreImage/CoreImage.h>

@interface PEASuperFilter : CIFilter
{
    CIImage *inputImage;
}
@property (retain, nonatomic) CIImage *inputImage;

@end
