//
//  IWAViewController.m
//  InstaWhat?
//
//  Created by Jo Albright on 8/21/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "IWAViewController.h"

#import "IWAFilterViewController.h"

#import <AssetsLibrary/AssetsLibrary.h>

@interface IWAViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation IWAViewController
{
    UIImagePickerController * imagePicker;
    
    NSMutableArray * photos;
    
    ALAssetsLibrary * library;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    photos = [@[] mutableCopy];
    
    imagePicker = [[UIImagePickerController alloc] init];
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    imagePicker.showsCameraControls = NO;
    imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    imagePicker.delegate = self;
    
    
    [self.view addSubview:imagePicker.view];
    
    [self addChildViewController:imagePicker];
    
    imagePicker.view.frame = CGRectMake(10, 10, 300, 300);
    
    
    UIButton * takePictureButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 370, 100, 100)];
    
    takePictureButton.backgroundColor = [UIColor blackColor];
    [takePictureButton addTarget:self action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.view addSubview:takePictureButton];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(90, 90);
    
    UICollectionView * photoCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 320, 300, [UIScreen mainScreen].bounds.size.height - 330) collectionViewLayout:layout];
    
    photoCollection.dataSource = self;
    photoCollection.delegate = self;
    photoCollection.backgroundColor = [UIColor whiteColor];
    
    [photoCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:photoCollection];
    
    library = [[ALAssetsLibrary alloc] init];
    
    [library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup * group, BOOL * stop) {
        
        [group enumerateAssetsUsingBlock:^(ALAsset * result, NSUInteger index, BOOL * stop) {
            
            NSLog(@"type %@",[result valueForProperty:ALAssetPropertyType]);
            
            if(result) [photos addObject:result];
            
            [photoCollection reloadData];
            
        }];
        
    } failureBlock:^(NSError *error) {
        
    }];
    
    UIButton * cameraButton = [[UIButton alloc] initWithFrame:CGRectMake(110, 260, 100, 100)];
    
    cameraButton.layer.cornerRadius = 50;
    cameraButton.backgroundColor = [UIColor orangeColor];
    cameraButton.layer.borderWidth = 10;
    cameraButton.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [cameraButton addTarget:self action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:cameraButton];
}

- (void)takePicture
{
    [imagePicker takePicture];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    ALAsset * photo = photos[indexPath.item];
    
    UIImageView * thumbnailView = [[UIImageView alloc] initWithFrame:cell.bounds];
    
    thumbnailView.image = [UIImage imageWithCGImage:photo.thumbnail];
    
    [cell.contentView addSubview:thumbnailView];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UIImageView * bigView = [[UIImageView alloc] initWithFrame:imagePicker.view.frame];
    
    ALAsset * photo = photos[indexPath.item];
    
    ALAssetRepresentation * representation = photo.defaultRepresentation;
    
//    bigView.image = [UIImage imageWithCGImage:representation.fullResolutionImage];
//    [self.view addSubview:bigView];
    
    // push viewcontrolller
    
    [self showFilterWithImage:[UIImage imageWithCGImage:representation.fullResolutionImage]];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
//    UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
//    imageView.image = info[UIImagePickerControllerOriginalImage];
//    [self.view addSubview:imageView];
    
    // push viewcontroller
    
    [self showFilterWithImage:info[UIImagePickerControllerOriginalImage]];
}

- (void)showFilterWithImage:(UIImage *)image
{
    IWAFilterViewController * filterVC = [[IWAFilterViewController alloc] init];
    
    filterVC.originalImage = image;
    
    [self.navigationController pushViewController:filterVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
