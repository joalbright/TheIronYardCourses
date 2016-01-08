//
//  MSAFirstViewController.m
//  Mayorships
//
//  Created by Jo Albright on 8/19/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "MSAFirstViewController.h"

#import "MSARequest.h"

#import <CoreLocation/CoreLocation.h>

@interface MSAFirstViewController () <UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>

@end

@implementation MSAFirstViewController
{
    NSArray * mayorships;
    
    CLLocationManager * locationManager;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
    self.mayorList.dataSource = self;
    self.mayorList.delegate = self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [locationManager stopUpdatingLocation];

    CLLocation * location = locations[0];
    
//    mayorships = [MSARequest findMayorshipsWithLocation:location];
    
    [MSARequest findMayorshipsWithLocation:location completion:^(NSArray * mayors) {
        
        mayorships = mayors;
        [self.mayorList reloadData];
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mayorships.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [self.mayorList dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSDictionary * mayor = mayorships[indexPath.row];
    
    ////////// PHOTO
    
    NSString * photoURL = [NSString stringWithFormat:@"%@100x100%@",mayor[@"user"][@"photo"][@"prefix"],mayor[@"user"][@"photo"][@"suffix"]];
    
    NSURL * url = [NSURL URLWithString:photoURL];
    
    NSString * documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    NSString * filePath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",mayor[@"user"][@"id"]]];

    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    
    if (!fileExists)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            
            NSData * photoData = [NSData dataWithContentsOfURL:url];
            [photoData writeToFile:filePath atomically:YES];
            
            NSLog(@"file request : %@",photoURL);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                cell.imageView.image = [UIImage imageWithData:photoData];
                
            });
            
        });
        
    } else {
        
        cell.imageView.image = [UIImage imageWithContentsOfFile:filePath];
    }
    
    cell.textLabel.text = mayor[@"user"][@"firstName"];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
