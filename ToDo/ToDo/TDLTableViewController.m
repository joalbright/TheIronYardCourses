//
//  TDLTableViewController.m
//  ToDo
//
//  Created by Jo Albright on 4/2/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "TDLTableViewController.h"

#import "TDLTableViewCell.h"

@implementation TDLTableViewController
{
    NSArray * listItems;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {

        listItems = @[
        @{@"name" : @"Ali Houshmand", @"image" : [UIImage imageNamed:@"alihoushmand"], @"github" :@"https://github.com/HoushmandA06" },
        @{@"name" : @"Ashby Thornwell", @"image" : [UIImage imageNamed:@"ashbythornwell"], @"github" :@"https://github.com/athornwell"},
        @{@"name" : @"Austen Johnson", @"image" : [UIImage imageNamed:@"austenjohnson"], @"github" :@"https://github.com/ajohnson21"},
        @{@"name" : @"Austin Nolan", @"image" : [UIImage imageNamed:@"austinnolan"], @"github" :@"https://github.com/adnolan99"},
        @{@"name" : @"Derek Weber", @"image" : [UIImage imageNamed:@"derekweber"], @"github" :@"https://github.com/dweber03"},
        @{@"name" : @"Ed Salter", @"image" : [UIImage imageNamed:@"edsalter"], @"github" :@"https://github.com/MadArkitekt"},
        @{@"name" : @"Heidi", @"image" : [UIImage imageNamed:@"heidi"], @"github" :@"https://github.com/justagirlcoding"},
        @{@"name" : @"Jeff King", @"image" : [UIImage imageNamed:@"jeffking"], @"github" :@"https://github.com/rampis"},
        @{@"name" : @"Jeffery Moulds", @"image" : [UIImage imageNamed:@"jefferymoulds"], @"github" :@"https://github.com/jdmgithub"},
        @{@"name" : @"Jisha Obukwelu", @"image" : [UIImage imageNamed:@"jishaobukwelu"], @"github" :@"https://github.com/Jiobu"},
        @{@"name" : @"John Yam", @"image" : [UIImage imageNamed:@"johnyam"], @"github" :@"https://github.com/yamski"},
        @{@"name" : @"Jon Fox", @"image" : [UIImage imageNamed:@"jonfox"], @"github" :@"https://github.com/FoxJon"},
        @{@"name" : @"Savitha Reddy", @"image" : [UIImage imageNamed:@"savithareddy"], @"github" :@"https://github.com/savithareddy"},
        @{@"name" : @"Teddy Conyers", @"image" : [UIImage imageNamed:@"teddyconyers"], @"github" :@"https://github.com/talented76"},
        @{@"name" : @"T.J. Mercer", @"image" : [UIImage imageNamed:@"tjmercer"], @"github" :@"https://github.com/gwanunig14"}
        ];
        
        self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
        self.tableView.rowHeight = 100;
        
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
        
        UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
//        header.backgroundColor = [UIColor redColor];
        self.tableView.tableHeaderView = header;
        
        UITextField * nameField = [[UITextField alloc] initWithFrame:CGRectMake(20, 20, 160, 30)];
        nameField.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        nameField.layer.cornerRadius = 6;
        nameField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
        nameField.leftViewMode = UITextFieldViewModeAlways;
        
        [header addSubview:nameField];
        
        UIButton * submitButton = [[UIButton alloc] initWithFrame:CGRectMake(200, 20, 100, 30)];
        [submitButton setTitle:@"New User" forState:UIControlStateNormal];
        submitButton.titleLabel.font = [UIFont systemFontOfSize:12];
        submitButton.backgroundColor = [UIColor darkGrayColor];
        submitButton.layer.cornerRadius = 6;
        [header addSubview:submitButton];
        
        UILabel * titleHeader = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, 280, 30)];
        titleHeader.text = @"GitHub Users";
        titleHeader.textColor = [UIColor lightGrayColor];
        titleHeader.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:30];
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
    TDLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) cell = [[TDLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    int index = indexPath.row;

//    NSDictionary * listItem = [listItems objectAtIndex:index];
    NSDictionary * listItem = listItems[index];
    
    cell.profileInfo = listItem;
    
//    cell.textLabel.text = [listItem objectForKey:@"name"];
//    cell.textLabel.text = listItems[index][@"name"];
//    
//    [[cell imageView] setImage:listItem[@"image"]];
//    cell.imageView.image = listItem[@"image"];
    
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
