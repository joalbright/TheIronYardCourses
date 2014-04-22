//
//  SLFTableViewController.m
//  Selfy
//
//  Created by Jo Albright on 4/22/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "SLFTableViewController.h"

#import "SLFTableViewCell.h"

#import <Parse/Parse.h>

@interface SLFTableViewController ()

@end

@implementation SLFTableViewController
{
    NSMutableArray * selfies;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
        
        selfies = [@[
                     
                     @{
                        
                        @"image" : @"http://distilleryimage7.ak.instagram.com/6756ea06a44b11e2b62722000a1fbc10_7.jpg",
                        @"caption" : @"This is a selfy!",
                        @"user_id" : @"3n2mb23bnm",
                        @"avatar" : @"https://media.licdn.com/mpr/mpr/shrink_200_200/p/4/005/036/354/393842f.jpg",
                        @"selfy_id" : @"hjk2l32bn1"
                        
                        }
                     
                     ] mutableCopy];
        
//        PFObject *testObject = [PFObject objectWithClassName:@"ChocolateBar"];
//        testObject[@"brand"] = @"Godiva";
//        testObject[@"type"] = @"dark";
//        [testObject saveInBackground];
//        
//        PFUser * user = [PFUser currentUser];
//        
//        user.username = @"Hello";
//        user.password = @"password";
//        
//        [user saveInBackground];
        
        self.tableView.rowHeight = self.tableView.frame.size.width + 100;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [selfies count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) cell = [[SLFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    cell.selfyInfo = selfies[indexPath.row];
//    [cell setSelfyInfo:selfies[indexPath.row]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
