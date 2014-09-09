//
//  IWAFilterViewController.m
//  InstaWhat?
//
//  Created by Jo Albright on 8/25/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "IWAFilterViewController.h"
#import "IWAChosenViewController.h"

@interface IWAFilterViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation IWAFilterViewController
{
    UIImageView * imageView;
    
    UICollectionView * filterCollection;
    
    NSArray * filters;
    
    NSMutableDictionary * filteredByKey;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.view.backgroundColor = [UIColor whiteColor];
        
        filteredByKey = [@{} mutableCopy];
        
        filters = @[
//                    @"CIColorCrossPolynomial",
//                    @"CIColorCube",
//                    @"CIColorCubeWithColorSpace",
                    @"CIColorInvert",
//                    @"CIColorMap",
                    @"CIColorMonochrome",
//                    @"CIColorPosterize",
//                    @"CIFalseColor",
//                    @"CIMaskToAlpha",
//                    @"CIMaximumComponent",
//                    @"CIMinimumComponent",
//                    @"CIPhotoEffectChrome",
//                    @"CIPhotoEffectFade",
//                    @"CIPhotoEffectInstant",
//                    @"CIPhotoEffectMono",
//                    @"CIPhotoEffectNoir",
//                    @"CIPhotoEffectProcess",
//                    @"CIPhotoEffectTonal",
//                    @"CIPhotoEffectTransfer",
                    @"CISepiaTone",
                    @"CIVignette",
                    @"CIVignetteEffect"
                    ];

        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 300)];
        
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        
        [self.view addSubview:imageView];
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.itemSize = CGSizeMake(100, 100);
        
        filterCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 320, 300, [UIScreen mainScreen].bounds.size.height - 310) collectionViewLayout:layout];
        
        filterCollection.dataSource = self;
        filterCollection.delegate = self;
        filterCollection.backgroundColor = [UIColor whiteColor];

        
        [filterCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        [self.view addSubview:filterCollection];
        
    }
    return self;
}

- (void)setOriginalImage:(UIImage *)originalImage
{
    _originalImage = originalImage;
    
    imageView.image = originalImage;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return filters.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSString * filterName = filters[indexPath.item];
    
    UIImageView * filterView = [[UIImageView alloc] initWithFrame:cell.bounds];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        UIImage * filterImage = [self filterImageWithFilterName:filterName];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            filterView.image = filterImage;
            filteredByKey[filterName] = filterImage;
            
        });
        
        
    });
    
//    filterView.image = [self filterImageWithFilterName:filterName];
    
    
    [cell addSubview:filterView];
    
    
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)filterImageWithFilterName:(NSString *)filterName
{
    // turn uiimage into ciimage
    CIImage * ciImage = [CIImage imageWithCGImage:self.originalImage.CGImage];
    
    // create cifilter with filterName
    CIFilter * filter = [CIFilter filterWithName:filterName];
    
    // add ciimage to the filter
    [filter setValue:ciImage forKeyPath:kCIInputImageKey];
    
    // get filtered image from filter
    CIImage * ciResult = [filter outputImage];
    
    // setup context to turn ciimage into cgimage
    CIContext * ciContext = [CIContext contextWithOptions:nil];
    
    // init uiimage with cgimage
    return [UIImage imageWithCGImage:[ciContext createCGImage:ciResult fromRect:[ciResult extent]]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    UIImageView * bigView = [[UIImageView alloc] initWithFrame:imagePicker.view.frame];
    
    NSString * filterName = filters[indexPath.item];
    
    [self chooseFilterWithImage:filteredByKey[filterName]];
}

- (void)chooseFilterWithImage:(UIImage *)image
{
    IWAChosenViewController * filterVC = [[IWAChosenViewController alloc] init];
    
    filterVC.filteredImage = image;
    
    [self.navigationController pushViewController:filterVC animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
