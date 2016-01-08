//
//  PEASuperFilter.m
//  Photo Editor
//
//  Created by Jo Albright on 5/2/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "PEASuperFilter.h"

@implementation PEASuperFilter

@synthesize inputImage;

+ (PEASuperFilter *)filterWithName:(NSString *)name
{
    NSLog(@"%@",name);
    return (PEASuperFilter *)[super filterWithName:name];
}

- (CIImage *)outputImage
{
    NSLog(@"%@",self.name);
    if([self.name isEqualToString:@"SuperFilter"])
    {
        CIFilter * sepiaFilter = [CIFilter filterWithName:@"CISepiaTone"];
        
        [sepiaFilter setValue:[self valueForKeyPath:kCIInputImageKey] forKeyPath:kCIInputImageKey];
        
        CIImage * image = [sepiaFilter valueForKeyPath:kCIOutputImageKey];
        
        CIFilter * bumpFilter = [CIFilter filterWithName:@"CIBumpDistortion"];
        
        [bumpFilter setValue:image forKeyPath:kCIInputImageKey];
        
        [bumpFilter setValue:@(2.0) forKeyPath:kCIInputScaleKey];
        
        return [bumpFilter valueForKeyPath:kCIOutputImageKey];
    }
    NSLog(@"hello");
    return [super outputImage];
}

@end
