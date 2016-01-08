//
//  ViewController.m
//  Speaking
//
//  Created by Jo Albright on 1/13/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

#import "ViewController.h"
#import "MyView.h"

@interface ViewController () <MyViewDelegate>

@end

@implementation ViewController
{
    MyView * view1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    view1 = [[MyView alloc] init];
    
    view1.delegate = self;
    
    view1.name = @"Bob";
    
    
    NSLog(@"view1 name = %@",view1.name);
    
}

- (void)changeMyNameTo:(NSString *)name {
    
    NSLog(@"%@",name);
    
//    view1.name = @"Bob";
    
    NSLog(@"view1 new name = %@",view1.name);
    
}

@end








