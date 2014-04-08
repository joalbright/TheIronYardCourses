//
//  TDLTableViewController.m
//  ToDo
//
//  Created by Jo Albright on 4/2/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "TDLTableViewController.h"

#import "TDLTableViewCell.h"

#import "TDLGitHubRequest.h"

@implementation TDLTableViewController
{
    NSMutableArray * listItems;
    UITextField * nameField;
}

- (void)toggleEdit
{
    [self.tableView setEditing:!self.tableView.editing animated:YES];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        UIBarButtonItem * editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(toggleEdit)];
        
        self.navigationItem.rightBarButtonItem = editButton;
        
        listItems = [@[
                       @{
                           @"name" : @"Jo Albright",
                           @"image" : @"https://avatars.githubusercontent.com/u/1536630?",
                           @"github" : @"https://github.com/joalbright"
                           },
                       @{
                           @"name" : @"John Yam",
                           @"image" : @"https://avatars1.githubusercontent.com/u/2688381?",
                           @"github" : @"https://github.com/yamski"
                           }
                       ] mutableCopy];
        
        self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
        self.tableView.rowHeight = 100;
        
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
        
        UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
        //    header.backgroundColor = [UIColor redColor];
        self.tableView.tableHeaderView = header;
        
        nameField = [[UITextField alloc] initWithFrame:CGRectMake(20, 20, 160, 30)];
        nameField.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        nameField.layer.cornerRadius = 6;
        nameField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
        nameField.leftViewMode = UITextFieldViewModeAlways;
        
        nameField.delegate = self;
        
        [header addSubview:nameField];
        
        UIButton * submitButton = [[UIButton alloc] initWithFrame:CGRectMake(200, 20, 100, 30)];
        [submitButton setTitle:@"New User" forState:UIControlStateNormal];
        submitButton.titleLabel.font = [UIFont systemFontOfSize:12];
        submitButton.backgroundColor = [UIColor darkGrayColor];
        submitButton.layer.cornerRadius = 6;
        [submitButton addTarget:self action:@selector(newUser) forControlEvents:UIControlEventTouchUpInside];
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
    
}

- (void)newUser
{
    NSString * username = nameField.text;
    
    nameField.text = @"";
    
//    [listItems addObject:@{
//    @"name" : username,
//    @"image" : [UIImage imageNamed:@"new_user"],
//    @"github" : [NSString stringWithFormat:@"https://github.com/%@",username]}
//    ];
    
    NSDictionary * userInfo = [TDLGitHubRequest getUserWithUsername:username];
    
    if([[userInfo allKeys] count] == 3) [listItems addObject:userInfo];
    else NSLog(@"not enough data");
    
    [nameField resignFirstResponder];
    [self.tableView reloadData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self newUser];
    return YES;
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
    
//    NSDictionary * listItem = [self getListItem:indexPath.row];
    
    cell.profileInfo = [self getListItem:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * listItem = [self getListItem:indexPath.row];
    
    NSLog(@"%@",listItem);
    
    UIViewController * webController = [[UIViewController alloc] init];

    UIWebView * webView = [[UIWebView alloc] init];

    webController.view = webView;
    
    [self.navigationController pushViewController:webController animated:YES];
    
    NSURL * url = [NSURL URLWithString:listItem[@"github"]];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [listItems removeObjectAtIndex:indexPath.row];
    
    NSDictionary * listItem = [self getListItem:indexPath.row];
    
    [listItems removeObjectIdenticalTo:listItem];
    
    [self.tableView reloadData];
    
    NSLog(@"%@",listItems);
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    if (sourceIndexPath == destinationIndexPath) return;
        
    // we will switch array objects here
    
    NSDictionary * sourceItem = [self getListItem:sourceIndexPath.row];
    
    NSDictionary * toItem = [self getListItem:destinationIndexPath.row];
    
    [listItems removeObjectIdenticalTo:sourceItem];
//    [listItems removeObjectAtIndex:[listItems indexOfObject:sourceItem]];
    [listItems insertObject:sourceItem atIndex:[listItems indexOfObject:toItem]];
    
}

- (NSDictionary *)getListItem:(NSInteger)row
{
    NSArray * reverseArray = [[listItems reverseObjectEnumerator] allObjects];
    return reverseArray[row];
}

@end
