//
//  GFATableViewController.m
//  Github Friends
//
//  Created by Jo Albright on 7/24/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "GFATableViewController.h"

#import "GFATableViewCell.h"

#import "GFAViewController.h"

#import "GRAGithubRequest.h"

@interface GFATableViewController ()

@end

@implementation GFATableViewController
{
    NSMutableArray * githubFriends;
    
    UITextField * searchField;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        self.tableView.backgroundColor = [UIColor colorWithRed:0.227f green:0.227f blue:0.227f alpha:1.0f];
        
        // Custom initialization
        
        githubFriends = [@[] mutableCopy];
        
        NSArray * loadedUsers = [GRAGithubRequest loadUsers];
        
        if (loadedUsers)
        {
            githubFriends = [loadedUsers mutableCopy];
        }
        
        self.tableView.rowHeight = 100;
        
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    
    headerView.backgroundColor = [UIColor colorWithRed:0.965f green:0.125f blue:0.341f alpha:1.0f];
    
    self.tableView.tableHeaderView = headerView;
    
    searchField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 250, 40)];
    
    searchField.layer.cornerRadius = 8;
    searchField.backgroundColor = [UIColor whiteColor];
    
    [headerView addSubview:searchField];
    
    UIButton * searchButton = [[UIButton alloc] initWithFrame:CGRectMake(270, 10, 40, 40)];
    
    searchButton.backgroundColor = [UIColor whiteColor];
    searchButton.layer.cornerRadius = 20;
    
    [searchButton addTarget:self action:@selector(addUser) forControlEvents:UIControlEventTouchUpInside];
    
    [headerView addSubview:searchButton];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)addUser
{
    NSLog(@"search button clicked");
    
    NSDictionary * userInfo = [GRAGithubRequest requestUserInfo:searchField.text];
    
    // add an object to the end
//    [githubFriends addObject:userInfo];
    
    // add an object to the beginning
    [githubFriends insertObject:userInfo atIndex:0];
    
    [self.tableView reloadData];
    
    [GRAGithubRequest saveUsers:githubFriends];
    
    [searchField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return githubFriends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GFATableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    if (cell == nil)
    {
        cell = [[GFATableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.friendInfo = githubFriends[indexPath.row];
    cell.navigationController = self.navigationController;
    
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Select row at %@",indexPath);
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [githubFriends removeObjectAtIndex:indexPath.row];
        
        [GRAGithubRequest saveUsers:githubFriends];
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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
