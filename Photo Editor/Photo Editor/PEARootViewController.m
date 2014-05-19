//
//  PEARootViewController.m
//  Photo Editor
//
//  Created by Jo Albright on 4/30/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//


#import "PEARootViewController.h"

#import "PEAFilterController.h"

#import <AssetsLibrary/AssetsLibrary.h>

#import "ControlsViewController.h"
#import "BlurViewController.h"
#import "HSBColorControlVC.h"

@interface PEARootViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate,PEAFilterControllerDelegate,BlurViewControllerDelegate,HSBColorControlVCDelegate,ControlsViewControllerDelegate>

@property (nonatomic) UIImage * originalImage;

@end

@implementation PEARootViewController
{
    UIImageView * imageView;
    
    PEAFilterController * filterVC;
    BlurViewController * blurVC;
    HSBColorControlVC * hsbVC;
    ControlsViewController * controlsVC;
}

- (void)viewDidLoad
{    
    imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.view addSubview:imageView];
    
    
    UIView * navBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    navBar.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
    
    [self.view addSubview:navBar];
    
    UIButton * libraryButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    
    libraryButton.layer.cornerRadius = 15;
    libraryButton.backgroundColor = [UIColor whiteColor];
    
    [libraryButton addTarget:self action:@selector(choosePhoto) forControlEvents:UIControlEventTouchUpInside];
    
    [navBar addSubview:libraryButton];
    
    controlsVC = [[ControlsViewController alloc] initWithNibName:nil bundle:nil];
    
    controlsVC.delegate = self;
    
    controlsVC.view.frame = CGRectMake(0, SCREEN_HEIGHT - 140, SCREEN_WIDTH, 40);
    
    [self.view addSubview:controlsVC.view];
    
    blurVC = [[BlurViewController alloc] initWithNibName:nil bundle:nil];
    
    blurVC.delegate = self;
    
    blurVC.view.frame = CGRectMake(0, SCREEN_HEIGHT - 100, SCREEN_WIDTH, 100);

//    [self.view addSubview:blurVC.view];
    
    hsbVC = [[HSBColorControlVC alloc] initWithNibName:nil bundle:nil];
    
    hsbVC.delegate = self;
    
    hsbVC.view.frame = CGRectMake(0, SCREEN_HEIGHT - 100, SCREEN_WIDTH, 100);
    
//    [self.view addSubview:hsbVC.view];
    
    filterVC = [[PEAFilterController alloc] initWithNibName:nil bundle:nil];
    filterVC.delegate = self;
    
    filterVC.view.frame = CGRectMake(0, SCREEN_HEIGHT - 100, SCREEN_WIDTH, 100);

    [self.view addSubview:filterVC.view];
    
    
    
    
//    ALAssetsLibrary * library = [[ALAssetsLibrary alloc] init];
//    
//    NSUInteger groupTypes = ALAssetsGroupAlbum | ALAssetsGroupEvent | ALAssetsGroupFaces | ALAssetsGroupSavedPhotos;
//    
//    [library enumerateGroupsWithTypes:groupTypes usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
//        
////        NSLog(@"%@",group);
////        NSLog(@"%d",(int)[group numberOfAssets]);
//        
//        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
//           
//            NSLog(@"%@",[result valueForProperty:ALAssetPropertyAssetURL]);
//            ALAssetRepresentation *rep = [result defaultRepresentation];
//            CGImageRef iref = [rep fullResolutionImage];
//            if (iref) {
//                self.currentImage = [UIImage imageWithCGImage:iref];
//            }
//
//            if(self.currentImage == nil) self.currentImage = [UIImage imageWithCGImage:result.thumbnail];
//            
//        }];
//        
//    } failureBlock:^(NSError *error) {
//        
//    }];
    
    
}

- (void)selectHsb
{
    [filterVC.view removeFromSuperview];
    [blurVC.view removeFromSuperview];
    
    [self.view addSubview:hsbVC.view];
}

- (void)selectFilter
{
    [blurVC.view removeFromSuperview];
    [hsbVC.view removeFromSuperview];
    
    [self.view addSubview:filterVC.view];
}

- (void)selectBlur
{
    [filterVC.view removeFromSuperview];
    [hsbVC.view removeFromSuperview];
    
    [self.view addSubview:blurVC.view];
}

- (void)choosePhoto
{
    UIImagePickerController * photoLibrary = [[UIImagePickerController alloc] init];
    
    photoLibrary.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    photoLibrary.delegate = self;
//    photoLibrary.allowsEditing = YES;
    
    [self presentViewController:photoLibrary animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{    
    self.originalImage = info[UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)setOriginalImage:(UIImage *)originalImage
{
    _originalImage = originalImage;
    
    filterVC.imageToFilter = originalImage;
    blurVC.imageToFilter = originalImage;
    hsbVC.currentImage = originalImage;
    imageView.image = originalImage;
}



- (void)updateCurrentImageWithFilteredImage:(UIImage *)image
{
    imageView.image = image;
}

- (void)updateCurrentImageWithHSB:(UIImage *)image
{
    imageView.image = image;
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (BOOL)prefersStatusBarHidden { return YES; }

@end
