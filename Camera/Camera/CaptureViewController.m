//
//  CaptureViewController.m
//  Camera
//
//  Created by Jo Albright on 10/19/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

#import "CaptureViewController.h"

#import "FilterViewController.h"

#import "ImageEditing.h"

@interface CaptureViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *cameraHolderView;

@property UIImagePickerController * picker;

@end

@implementation CaptureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.picker = [[UIImagePickerController alloc] init];
    self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    self.picker.delegate = self;
    self.picker.showsCameraControls = NO;
    
    self.picker.view.frame = self.cameraHolderView.bounds;
    
    [self.cameraHolderView addSubview:self.picker.view];
    
}

- (void)viewDidLayoutSubviews {
    
    NSLog(@"%f %f",self.cameraHolderView.bounds.size.width,self.cameraHolderView.bounds.size.height);
    
    CGRect newFrame = self.picker.view.frame;
    
    newFrame.size.width = newFrame.size.height / 4 * 3;
    
    newFrame.origin.x = (self.cameraHolderView.frame.size.width - newFrame.size.width) / 2;
    
    NSLog(@"%f %f",newFrame.size.width,newFrame.size.height);
    
    self.picker.view.frame = newFrame;
    
}

- (IBAction)takePicture:(id)sender {
    
    [self.picker takePicture];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage * image = info[UIImagePickerControllerOriginalImage];
    
    FilterViewController * filterVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FilterVC"];
    
    // pass the image
    filterVC.originalImage = flipImage(image);
    
    [self.navigationController pushViewController:filterVC animated:YES];
    
}


@end
