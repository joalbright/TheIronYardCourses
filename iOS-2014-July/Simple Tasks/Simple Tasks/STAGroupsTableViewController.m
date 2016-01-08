//
//  STAGroupsTableViewController.m
//  Simple Tasks
//
//  Created by Jo Albright on 7/30/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "STAGroupsTableViewController.h"

#import "STAItemsTableViewController.h"
#import "STANewGroupViewController.h"

@interface STAGroupsTableViewController ()

@end

@implementation STAGroupsTableViewController
{
    NSMutableArray * groups;
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
        
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);

        groups = ([self loadGroupData]) ? [self loadGroupData] : [@[] mutableCopy];
        
//        NSMutableArray * loadGroupsArray = [self loadGroupData];
//        
//        if (loadGroupsArray)
//        {
//            groups = loadGroupsArray;
//        }
        

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UIBarButtonItem * addNewGroup = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewGroupClicked)];
    
    self.navigationItem.rightBarButtonItem = addNewGroup;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//     self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"%@",groups);
    
    [self saveGroupData];
    
    [self.tableView reloadData];
}

- (void)addNewGroupClicked
{
    STANewGroupViewController * addNewGroupVC = [[STANewGroupViewController alloc] init];
    
    addNewGroupVC.groups = groups;
    
    [self.navigationController presentViewController:addNewGroupVC animated:YES completion:nil];
    
    // subclass UIViewController ... STANewGroupViewController
    
    // add textfield for group name
    
    // add 2 buttons for cancel and save
    
    // pass the groups array to the VC
    
    // save creates NSMutableDictionary and adds it to the groups array
    
    // save & cancel "dismiss" the VC
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return groups.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = groups[indexPath.row][@"name"];
    
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    STAItemsTableViewController * itemsTVC = [[STAItemsTableViewController alloc] init];
    
    itemsTVC.groupInfo = groups[indexPath.row];
    
    [self.navigationController pushViewController:itemsTVC animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source
        
        [groups removeObjectAtIndex:indexPath.row];
        [self saveGroupData];
        
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

- (void)saveGroupData
{
    NSData * groupData = [NSKeyedArchiver archivedDataWithRootObject:groups];
    [groupData writeToFile:[self groupFilePath] atomically:YES];
}

- (NSMutableArray *)loadGroupData
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self groupFilePath]];
}

- (NSString *)groupFilePath
{
    NSArray * documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString * path = documentDirectories[0];
    
    return [path stringByAppendingPathComponent:@"groups.data"];
}

- (BOOL)prefersStatusBarHidden { return YES; }

@end
