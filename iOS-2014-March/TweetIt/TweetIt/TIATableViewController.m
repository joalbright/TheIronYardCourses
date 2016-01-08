//
//  TIATableViewController.m
//  TweetIt
//
//  Created by Jo Albright on 4/21/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "TIATableViewController.h"

#import "TIAViewController.h"

@interface TIATableViewController ()

@end

@implementation TIATableViewController
{
    NSArray * tweets;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        tweets = @[
                   @{
                       @"text":@"Inspiring Tweet",
                       @"name":@"Einstein",
                       @"type":@"quote"
                        },
                   @{
                       @"text":@"Funny Tweet",
                       @"name":@"Heidi",
                       @"type":@"icebreaker"
                       },
                   @{
                       @"text":@"Serious Look Tweet",
                       @"name":@"Ali",
                       @"type":@"look"
                       }
                   ];
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
    // Return the number of rows in the section.
    return [tweets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // tweet dictionary based on row
    NSDictionary * tweet = tweets[indexPath.row];
    
    // array of types for switch
    NSArray * types = @[@"quote",@"icebreaker",@"look"];
    
    // cell identifier that will be changed in switch
    NSString * reuseID = @"cell";
    
    // style for table cell that will be changed in switch
    UITableViewCellStyle style = UITableViewCellStyleDefault;
    
//    switch ([types indexOfObject:tweet[@"type"]])
//    {
//        case 0 : // quote
//            reuseID = @"cell0";
//            style = UITableViewCellStyleValue1;
//            break;
//            
//        case 1 : // icebreaker
//            reuseID = @"cell1";
//            style = UITableViewCellStyleValue2;
//            break;
//            
//        case 2 : // look
//            reuseID = @"cell2";
//            style = UITableViewCellStyleValue2;
//            break;
//            
//        default:
//            break;
//    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:style reuseIdentifier:reuseID];
    }

    // Configure the cell...
    
    cell.textLabel.text = tweet[@"text"];
    cell.detailTextLabel.text = tweet[@"name"];
    
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UITableViewCell * cell = sender;
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    
    NSDictionary * tweet = tweets[indexPath.row];
    
    if ([segue.identifier isEqualToString:@"tweetDetail"])
    {
        // tweetDetail
        
        TIAViewController * tweetDetailVC = segue.destinationViewController;
        
        tweetDetailVC.tweet = tweet;
        
//        NSLog(@"%@",tweetDetailVC.nameLabel);
//        
//        tweetDetailVC.nameLabel.text = tweet[@"name"];
//        tweetDetailVC.tweetLabel.text = tweet[@"text"];
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
