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
    NSMutableArray * listItems;
    UITextField * nameField;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {

        NSArray * array = @[
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
        
        listItems = [array mutableCopy];
        
        self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
        self.tableView.rowHeight = 100;
        
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
        
        UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
//        header.backgroundColor = [UIColor redColor];
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

- (void)newUser
{
    NSString * username = nameField.text;
    
    nameField.text = @"";
    
    [listItems addObject:@{
    @"name" : username,
//    @"image" : [UIImage imageNamed:@"new_user"],
    @"github" : [NSString stringWithFormat:@"https://github.com/%@",username]}
    ];
    
    [nameField resignFirstResponder];
    [self.tableView reloadData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self newUser];
    return YES;
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
    
//    NSDictionary * listItem = [self getListItem:indexPath.row];
    
    cell.profileInfo = [self getListItem:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * listItem = [self getListItem:indexPath.row];
    
    NSLog(@"%@",listItem);
    
//    UIViewController * webController = [[UIViewController alloc] init];
//    
//    UIWebView * webView = [[UIWebView alloc] init];
//    
//    webController.view = webView;
//    
//    UIWindow * window = [[UIApplication sharedApplication].windows firstObject];
//    
//    UINavigationController * navController = (UINavigationController *)window.rootViewController;
//    
//    [navController pushViewController:webController animated:YES];
//    
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:listItem[@"github"]]]];
}

- (NSDictionary *)getListItem:(NSInteger)row
{
    NSArray * reverseArray = [[listItems reverseObjectEnumerator] allObjects];
    return reverseArray[row];
}

@end
