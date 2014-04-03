//
//  TDLTableViewController.m
//  ToDo
//
//  Created by Jo Albright on 4/2/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "TDLTableViewController.h"

@implementation TDLTableViewController
{
    NSArray * listItems;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
//        NSDictionary * listExample = [[NSDictionary alloc] initWithObjects:@[@"Savitha Reddy"] forKeys:@[@"name"]];
        
//        NSDictionary * list = @{
//                                @"name" : @"Savitha Reddy",
//                                @"image" : [UIImage imageNamed:@"savithareddy"]
//                                };

        listItems = @[
                      @{@"name" : @"Savitha Reddy", @"image" : [UIImage imageNamed:@"savithareddy"]},
                      @{@"name" : @"Jeff King", @"image" : [UIImage imageNamed:@"jeffking"]}
                      ];
    
        self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
        self.tableView.rowHeight = 100;
        
        
        UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        header.backgroundColor = [UIColor darkGrayColor];
        self.tableView.tableHeaderView = header;
        
        
        UILabel * titleHeader = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 300, 30)];
        titleHeader.text = @"Something";
        titleHeader.textColor = [UIColor whiteColor];
        [header addSubview:titleHeader];
        
        
        
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

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [listItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) cell = [[UITableViewCell alloc] init];
    
//    int index = [indexPath row];
    int index = indexPath.row;
    
//    cell.textLabel.text = listItems[index];
//    cell.imageView.image = listImages[index];
    
    
//    NSDictionary * listItem = [listItems objectAtIndex:index];
    NSDictionary * listItem = listItems[index];
    
//    cell.textLabel.text = [listItem objectForKey:@"name"];
    cell.textLabel.text = listItems[index][@"name"];
    cell.imageView.image = listItem[@"image"];
    
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
