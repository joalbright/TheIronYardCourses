//
//  ControlsViewController.m
//  
//
//  Created by Savitha Reddy on 5/2/14.
//
//

#import "ControlsViewController.h"


@interface ControlsViewController ()

@end

@implementation ControlsViewController
{
    UIView *controlsView;
    UIButton *filtersButton;
    UIButton *hsbButton;
    UIButton *blurButton;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewWillLayoutSubviews
{
    [super viewDidLoad];
    
    controlsView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-140, SCREEN_WIDTH, 40)];
    controlsView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:controlsView ];
    
    filtersButton = [[UIButton alloc] initWithFrame:CGRectMake(39,5,30,30)];
    filtersButton.backgroundColor = [UIColor whiteColor];
    [filtersButton setImage:[UIImage imageNamed:@"filter"] forState:(UIControlStateNormal)];
    [filtersButton addTarget:self.delegate action:@selector(selectFilter) forControlEvents:UIControlEventTouchUpInside];
    [controlsView addSubview: filtersButton];
    
    hsbButton = [[UIButton alloc] initWithFrame:CGRectMake(145,5,30,30)];
    hsbButton.backgroundColor = [UIColor whiteColor];
    [hsbButton setImage:[UIImage imageNamed:@"HSB"] forState:(UIControlStateNormal)];
    [hsbButton addTarget:self.delegate action:@selector(selectHsb) forControlEvents:UIControlEventTouchUpInside];
    [controlsView addSubview: hsbButton];
    
    blurButton = [[UIButton alloc] initWithFrame:CGRectMake(252,5,30,30)];
    blurButton.backgroundColor = [UIColor whiteColor];
    [blurButton setImage:[UIImage imageNamed:@"blur"] forState:(UIControlStateNormal)];
    [blurButton addTarget:self.delegate action:@selector(selectBlur) forControlEvents:UIControlEventTouchUpInside];
    [controlsView addSubview: blurButton];
    
    controlsView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

//-(void) selectFilter
//{
//   // [self.delegate selectFilterTool];
//}
//
////-(void) selectHSB
////{
////  //[self.delegate selectHsbTool];
////}
//
//-(void) selectBlur
//{
//  //  [self.delegate selectBlurTool];
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


@end




