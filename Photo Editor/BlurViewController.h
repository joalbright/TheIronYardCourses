//
//  BlurViewController.h
//  
//
//  Created by T.J. Mercer on 5/2/14.
//
//

#import <UIKit/UIKit.h>

@protocol BlurViewControllerDelegate;

@interface BlurViewController : UIViewController

@property (nonatomic,assign) id<BlurViewControllerDelegate> delegate;

@property(nonatomic) UIImage * imageToFilter;

@end

@protocol BlurViewControllerDelegate <NSObject>

-(void)updateCurrentImageWithFilteredImage:(UIImage *)image;

@end
