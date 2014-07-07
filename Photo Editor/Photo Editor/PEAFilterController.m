//
//  PEAScrollController.m
//  Photo Editor
//
//  Created by Jo Albright on 4/30/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "PEAFilterController.h"

#import "PEASuperFilter.h"

@interface PEAFilterController ()

@property (nonatomic) NSString * currentFilter;

@end

@implementation PEAFilterController
{
    UIScrollView * scrollView;
    NSArray * filterNames;
    NSMutableArray * filterButtons;
//    NSMutableDictionary * filters;
//    CIContext * ciContext;
    
    float wh;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
        
        filterButtons = [@[] mutableCopy];
        filterNames = @[
                        @"SuperFilter",
                        @"CIColorInvert",
                        @"CIColorMonochrome",
                        @"CIColorPosterize",
//                        @"CIFalseColor",
//                        @"CIMaximumComponent",
//                        @"CIMinimumComponent",
//                        @"CIPhotoEffectChrome",
//                        @"CIPhotoEffectFade",
//                        @"CIPhotoEffectInstant",
//                        @"CIPhotoEffectMono",
//                        @"CIPhotoEffectNoir",
//                        @"CIPhotoEffectProcess",
//                        @"CIPhotoEffectTonal",
//                        @"CIPhotoEffectTransfer",
//                        @"CISepiaTone",
//                        @"CIVignette",
                        
//                        @"CIBumpDistortion",
//                        @"CIBumpDistortionLinear",
//                        @"CICircleSplashDistortion",
//                        @"CICircularWrap",
//                        @"CIDroste",
//                        @"CIDisplacementDistortion",
//                        @"CIGlassDistortion",
//                        @"CIGlassLozenge",
//                        @"CIHoleDistortion",
//                        @"CILightTunnel",
//                        @"CIPinchDistortion",
//                        @"CIStretchCrop",
//                        @"CITorusLensDistortion",
//                        @"CITwirlDistortion",
//                        @"CIVortexDistortion"


                        ];
        
        scrollView = [[UIScrollView alloc] init];
        [self.view addSubview:scrollView];
    }
    return self;
}

- (void)viewWillLayoutSubviews
{
    wh = self.view.frame.size.height - 20;
    
    for (NSString * filterName in filterNames)
    {
        int i = (int)[filterNames indexOfObject:filterName];
        int x = (wh + 10) * i + 10;
        
        UIButton * filterButton = [[UIButton alloc] initWithFrame:CGRectMake(x, 10, wh, wh)];
        filterButton.tag = i;
        filterButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
        
        [filterButton addTarget:self action:@selector(switchFilter:) forControlEvents:UIControlEventTouchUpInside];
        [filterButtons addObject:filterButton];
        
        [scrollView addSubview:filterButton];
    }
    
//    NSLog(@"%d",(int)self.view.frame.size.height);
    
    scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    scrollView.contentSize = CGSizeMake((wh + 10) * [filterNames count] + 10, self.view.frame.size.height);
}




- (UIImage *)filterImage:(UIImage *)image filterName:(NSString *)filterName
{
    
    CIImage * ciImage = [CIImage imageWithCGImage:image.CGImage];
    
    PEASuperFilter * filter = (PEASuperFilter *)[PEASuperFilter filterWithName:filterName];
    
    [filter setValue:ciImage forKeyPath:kCIInputImageKey];
    
    CIImage * ciResult = [filter outputImage];
    
    CIContext * ciContext = [CIContext contextWithOptions:nil];
    
    return [UIImage imageWithCGImage:[ciContext createCGImage:ciResult fromRect:[ciResult extent]]];
}




- (void)switchFilter:(UIButton *)filterButton
{
    self.currentFilter = [filterNames objectAtIndex:filterButton.tag];
    
    UIImage * image = [self filterImage:self.imageToFilter filterName:self.currentFilter];
    
    [self.delegate updateCurrentImageWithFilteredImage:image];
    
    
    
//    [self shrinkImage:self.imageToFilter maxWH:SCREEN_WIDTH * 2]
    
}


- (void)setImageToFilter:(UIImage *)imageToFilter
{
    _imageToFilter = imageToFilter;
    
    
    
//    UIImage * image = imageToFilter;
    
    for (UIButton * filterButton in filterButtons)
    {
        
        [filterButton setImage:nil forState:UIControlStateNormal];
        
        NSString * filterName = [filterNames objectAtIndex:filterButton.tag];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,(unsigned long)NULL), ^{
            
            UIImage * smallImage = [self shrinkImage:imageToFilter maxWH:wh * 2];
            UIImage * image = [self filterImage:smallImage filterName:filterName];
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
            
                [filterButton setImage:image forState:UIControlStateNormal];
                filterButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
                
            });
            
        });
        
    }
    
//
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,(unsigned long)NULL), ^(void) {
//            
//            UIImage * filteredImage = [UIImage imageWithCGImage:[self filterImage:[self shrinkImage:image maxWH:wh * 2] filterName:filterName]];
//            
//            dispatch_async(dispatch_get_main_queue(), ^(void) {
//                
//                [filterButton setImage:filteredImage forState:UIControlStateNormal];
//                filterButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
//                
//            });
//            
//        });
}



- (UIImage *)shrinkImage:(UIImage *)image maxWH:(int)widthHeight
{
    
    CGSize size = CGSizeMake(widthHeight, widthHeight / image.size.width * image.size.height);
    
    if(image.size.height < image.size.width)
    {
        size = CGSizeMake(widthHeight / image.size.height * image.size.width, widthHeight);
    }
    
    
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    return destImage;
}

@end
