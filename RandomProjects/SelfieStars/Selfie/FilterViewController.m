//
//  ViewController.m
//  TakeASelfie
//
//  Created by Jo Albright on 6/3/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

#import "FilterViewController.h"
#import "FilterCollectionViewCell.h"

@interface FilterViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *filterCollectionView;

@property (nonatomic) NSString * currentFilter;
@property (nonatomic) CGFloat currentIntensity;

@end

@implementation FilterViewController
{
    NSArray * filters;
    UIImage * resizedImage;
}

- (void)setCurrentIntensity:(CGFloat)currentIntensity {
    
    self.imageView.alpha = currentIntensity;
    
    _currentIntensity = currentIntensity;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.imageView.image = self.original;
    self.unfilteredImageView.image = self.original;
    
    self.currentIntensity = 1.0;
    
    resizedImage = [self resizeImage:self.original withSize:CGSizeMake(200, 200)];
    
    filters = [CIFilter filterNamesInCategory:kCICategoryColorEffect];
    
    self.filterCollectionView.dataSource = self;
    self.filterCollectionView.delegate = self;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return filters.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FilterCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"filterCell" forIndexPath:indexPath];
    
    NSString * filterName = filters[indexPath.item];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        UIImage * filteredImage = [self filterImage:resizedImage withName:filterName];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            cell.imageView.image = filteredImage;
            
        });
        
        
    });
    
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * filterName = filters[indexPath.item];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
    
        UIImage * resetImage = [self resizeImage:self.original withSize:self.original.size];
        
        UIImage * filteredImage = [self filterImage:resetImage withName:filterName];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.imageView.image = filteredImage;
            
        });
        
        
    });
    
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    
    CGRect scaleImageRect = CGRectMake(0, 0, size.width, size.height);
    
    if (size.height / size.width != image.size.height / image.size.width) {
        
        // fix ratio for square size
        
        if (image.size.height > image.size.width) { // portrait
            
            CGFloat ratio = size.width / image.size.width;
            CGFloat newHeight = ratio * image.size.height;
            CGFloat newY = (size.height - newHeight) / 2;
            scaleImageRect = CGRectMake(0, newY, size.width, newHeight);
            
        } else { // landscape
            
            CGFloat ratio = size.height / image.size.height;
            CGFloat newWidth = ratio * image.size.width;
            CGFloat newX = (size.width - newWidth) / 2;
            scaleImageRect = CGRectMake(newX, 0, newWidth, size.height);
            
        }
        
    }
    
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect:scaleImageRect];
    
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

- (UIImage *)filterImage:(UIImage *)originalImage withName:(NSString *)filterName {
    
    CIContext * context = [CIContext contextWithOptions:nil];
    
    CIImage * image = [CIImage imageWithCGImage:originalImage.CGImage];
    
    CIFilter * filter = [CIFilter filterWithName:filterName];
    
    [filter setValue:image forKey:kCIInputImageKey];
    
//    [filter setValue:@0.8f forKey:kCIInputIntensityKey];
    
    CIImage * result = [filter valueForKey:kCIOutputImageKey];
    
    CGRect extent = [result extent];
    
    CGImageRef cgImage = [context createCGImage:result fromRect:extent];
    
    return [UIImage imageWithCGImage:cgImage];
}

- (IBAction)goBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)filterIntensityChanged:(UISlider *)sender {
    
    self.currentIntensity = sender.value;
    
}


@end











