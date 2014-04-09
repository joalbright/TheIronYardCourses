//
//  TDLListTVC.m
//  ToBeDone
//
//  Created by Jo Albright on 4/8/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "TDLListTVC.h"

#import "TDLCell.h"

@implementation TDLListTVC
{
    NSMutableArray * listItems;
    UITextField * listItemField;
    NSArray * priorityColors;
    
    UIButton * lowButton;
    UIButton * medButton;
    UIButton * highButton;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        
        priorityColors = @[TAN_COLOR,YELLOW_COLOR,ORANGE_COLOR,RED_COLOR];
        
        listItems = [@[
                       @{
                           @"name":@"Workshop App",
                           @"priority" : @3
                        },
                       @{@"name":@"Go To Blogging Thing", @"priority" : @2},
                       @{@"name":@"Learn Objective - C", @"priority" : @1},
                       @{@"name":@"Finish GitHub App", @"priority" : @0}
                       ] mutableCopy];
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
        self.tableView.rowHeight = 50;
        
        listItemField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 150, 40)];
        listItemField.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        listItemField.leftViewMode = UITextFieldViewModeAlways;
        listItemField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
        listItemField.layer.cornerRadius = 6;
        
        [self.tableView.tableHeaderView addSubview:listItemField];
        
        lowButton = [[UIButton alloc] initWithFrame:CGRectMake(170, 10, 40, 40)];
        lowButton.tag = 1;
        lowButton.backgroundColor = YELLOW_COLOR;
        lowButton.layer.cornerRadius = lowButton.frame.size.width / 2.0;
        [lowButton addTarget:self action:@selector(addNewListItem:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableView.tableHeaderView addSubview:lowButton];
        
        medButton = [[UIButton alloc] initWithFrame:CGRectMake(220, 10, 40, 40)];
        medButton.tag = 2;
        medButton.backgroundColor = ORANGE_COLOR;
        medButton.layer.cornerRadius = medButton.frame.size.width / 2.0;
        [medButton addTarget:self action:@selector(addNewListItem:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableView.tableHeaderView addSubview:medButton];
        
        highButton = [[UIButton alloc] initWithFrame:CGRectMake(270, 10, 40, 40)];
        highButton.tag = 3;
        highButton.backgroundColor = RED_COLOR;
        highButton.layer.cornerRadius = highButton.frame.size.width / 2.0;
        [highButton addTarget:self action:@selector(addNewListItem:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableView.tableHeaderView addSubview:highButton];
        
        
    }
    return self;
}

- (void)addNewListItem:(id)sender
{
    UIButton * button = (UIButton *)sender;
    NSString * name = listItemField.text;
    
    if(![name isEqualToString:@""])
    {
        [listItems insertObject:@{@"name" : name, @"priority" : @(button.tag)} atIndex:0];
        
//        [listItems insertObject:@{@"name" : name, @"priority" : [NSNumber numberWithInteger:button.tag]} atIndex:0];
    }
    
    [listItemField resignFirstResponder];
    [self.tableView reloadData];
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
    return [listItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TDLCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell == nil) cell = [[TDLCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    NSDictionary * listItem = listItems[indexPath.row];
    
//    cell.backgroundColor = priorityColors[[listItem[@"priority"] intValue]];
    
    cell.bgView.backgroundColor = priorityColors[[listItem[@"priority"] intValue]];
    
    cell.textLabel.text = listItem[@"name"];
    
//    cell.bounds = CGRectMake(10, 10, 300, 40);
    
    // Configure the cell...
    
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

- (BOOL)prefersStatusBarHidden { return YES; }

@end
