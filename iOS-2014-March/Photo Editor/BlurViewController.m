//
//  BlurViewController.m
//
//
//  Created by T.J. Mercer on 5/2/14.
//
//

#import "BlurViewController.h"

@interface BlurViewController ()

@property (nonatomic) NSString * currentFilter;

@end

@implementation BlurViewController
{
    UISwitch * blurToggle;
    UISlider * blurIntensity;
    float blurLevel;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        blurLevel = 10;
        
        blurToggle = [[UISwitch alloc]initWithFrame:CGRectMake(260, 25, 20, 50)];
        blurToggle.on = YES;
        [blurToggle addTarget:self action:@selector(changeBlurType) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:blurToggle];
        
        blurIntensity = [[UISlider alloc]initWithFrame: CGRectMake(20, 25, 220, 50)];
        blurIntensity.minimumValue = 0.0;
        blurIntensity.maximumValue = 100.0;
        [blurIntensity addTarget:self action:@selector(changeBlurType) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:blurIntensity];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(void)changeBlurType
{
    if (blurToggle.on == YES)
    {
        self.currentFilter = @"CIBloom";
    }else{
        self.currentFilter = @"CIGaussianBlur";
    }
    
    blurLevel = blurIntensity.value;
    
    UIImage * image = [self filterImage:self.imageToFilter filterName:self.currentFilter];
    
    NSLog(@"%f", blurIntensity.value);
    
    [self.delegate updateCurrentImageWithFilteredImage:image];
}

- (UIImage *)filterImage:(UIImage*)image filterName:(NSString *)filterName
{
    CIImage * ciImage = [CIImage imageWithCGImage:image.CGImage];
    
    CIFilter * filter = [CIFilter filterWithName:filterName];
    
    [filter setValue:ciImage forKey:kCIInputImageKey];
    [filter setValue:@(blurLevel) forKey:kCIInputRadiusKey];
    
    CIContext * ciContext = [CIContext contextWithOptions:nil];
    
    CIImage * ciResult = [filter valueForKeyPath:kCIOutputImageKey];
    
    return [UIImage imageWithCGImage:[ciContext createCGImage:ciResult fromRect:[ciResult extent]]];
}

-(void)setImageToFilter:(UIImage *)imageToFilter
{
    _imageToFilter = imageToFilter;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
