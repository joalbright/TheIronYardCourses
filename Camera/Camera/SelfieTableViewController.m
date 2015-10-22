//
//  SelfieTableViewController.m
//  Camera
//
//  Created by Jo Albright on 10/19/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

#import "SelfieTableViewController.h"

#import "SelfieTableViewCell.h"

@interface SelfieTableViewController ()

@end

@implementation SelfieTableViewController
{
    NSMutableArray * selfies;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    selfies = [@[] mutableCopy];
    
    NSLog(@"view did load");
    
    PFQuery * selfieQuery = [PFQuery queryWithClassName:@"Selfie"];
    
    [selfieQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        for (PFObject * selfie in objects) {
            
            NSLog(@"%@",selfie);
            [selfies addObject:selfie];
            
        }
        
        NSLog(@"query did finish");
        [self.tableView reloadData];
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"%@",selfies);
    
    NSLog(@"current selfies count %d", (int)selfies.count);
    return selfies.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SelfieTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SelfieCell" forIndexPath:indexPath];
    
    NSLog(@"setting selfie on cell");
    cell.selfie = selfies[indexPath.row];
    
    return cell;
    
}

@end
