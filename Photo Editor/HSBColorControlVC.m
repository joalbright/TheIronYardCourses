//
//  HSBFilter.m
//  HueSaturationBrightness
//
//  Created by Jisha Obukwelu on 5/2/14.
//  Copyright (c) 2014 Jisha Obukwelu. All rights reserved.
//

#import "HSBColorControlVC.h"

@interface HSBColorControlVC ()

@end

@implementation HSBColorControlVC
{
    UISlider * saturationSlider;
    UISlider * brightnessSlider;
    UISlider * contrastSlider;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.view.backgroundColor = [UIColor greenColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    saturationSlider = [[UISlider alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 50, 20)];
    [saturationSlider addTarget:self action:@selector(applyFilter) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:saturationSlider];
    
    saturationSlider.maximumValue = 2;
    saturationSlider.minimumValue = 0;
    saturationSlider.value = 1.0;
    
    
    brightnessSlider = [[UISlider alloc] initWithFrame:CGRectMake(10, 40, SCREEN_WIDTH - 50, 20)];
    [brightnessSlider addTarget:self action:@selector(applyFilter) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:brightnessSlider];
    
    brightnessSlider.maximumValue = 1;
    brightnessSlider.minimumValue = -1;
    brightnessSlider.value = 0.0;
    
    contrastSlider = [[UISlider alloc] initWithFrame:CGRectMake(10, 70, SCREEN_WIDTH - 50, 20)];
    [contrastSlider addTarget:self action:@selector(applyFilter) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:contrastSlider];
   
    contrastSlider.maximumValue = 4;
    contrastSlider.minimumValue = 0;
    contrastSlider.value = 1.0;
    
    
    CIFilter *colorControls = [CIFilter filterWithName:@"CIColorControls"];
    
    NSLog(@"%@",[colorControls attributes]);

}

- (void)setCurrentImage:(UIImage *)currentImage
{
    _currentImage = currentImage;
    
    NSLog(@"%@", self.currentImage);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)applyFilter
{
    // 1 Get CIIMage
    CIImage* ciImage = [CIImage imageWithCGImage:self.currentImage.CGImage];
    
    // 2 Get Filter
    CIFilter *colorControls = [CIFilter filterWithName:@"CIColorControls"];
    
    NSLog(@"%@",[colorControls attributes]);
    
    // 3 Configure our filter with the values from our sliders
    // i.e. apply necessary keys for this specific filter
    
    [colorControls setValue:ciImage forKey:kCIInputImageKey];
    NSLog(@"hello");
    
    [colorControls setValue:@(saturationSlider.value) forKey:@"inputSaturation"];
    [colorControls setValue:@(brightnessSlider.value) forKey:@"inputBrightness"];
    [colorControls setValue:@(contrastSlider.value) forKey:@"inputContrast"];
    
    // 4 Run the filter against our image
    CIContext* ciContext = [CIContext contextWithOptions:nil];
    CIImage* ciResult = [colorControls valueForKeyPath:kCIOutputImageKey];
    CGImageRef cgImage = [ciContext createCGImage:ciResult fromRect:[ciResult extent]];
    
    
    // 5 Now finally we can get our UIImage
    UIImage* newImage = [UIImage imageWithCGImage:cgImage];
    
    // Update our property so we always have the 'last modified' image
//    self.currentImage = newImage;
    
    // Tell our delegate what the final image is!!
    [self.delegate updateCurrentImageWithHSB:newImage];
}

@end
