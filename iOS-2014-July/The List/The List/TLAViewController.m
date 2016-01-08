//
//  TLAViewController.m
//  The List
//
//  Created by Jo Albright on 8/22/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "TLAViewController.h"

@interface TLAViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation TLAViewController
{
    NSMutableArray * niceArray;
    NSMutableArray * naughtyArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    niceArray = [@[@"Helper Robots",@"Some Humans"] mutableCopy];
    naughtyArray = [@[@"Invading Aliens",@"Killer Robots",@"Jaws"] mutableCopy];
    
    UITabBarController * tabBarC = [[UITabBarController alloc] init];
    [self.view addSubview:tabBarC.view];
    [self addChildViewController:tabBarC];
    
    UITableViewController * niceList = [[UITableViewController alloc] init];
    niceList.title = @"Nice";
    niceList.tableView.dataSource = self;
    niceList.tableView.delegate = self;
    niceList.tableView.tag = 0;
    
    [niceList.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UITableViewController * naughtyList = [[UITableViewController alloc] init];
    naughtyList.title = @"Naughty";
    naughtyList.tableView.dataSource = self;
    naughtyList.tableView.delegate = self;
    naughtyList.tableView.tag = 1;
    
    
    
    [naughtyList.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    tabBarC.viewControllers = @[niceList,naughtyList];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 0)
    {
        return niceArray.count;
    }
    
    if (tableView.tag == 1)
    {
        return naughtyArray.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSArray * itemArray;
    
    if (tableView.tag == 0)
    {
        itemArray = niceArray;
    }
    
    if (tableView.tag == 1)
    {
        itemArray = naughtyArray;
    }
    
    cell.textLabel.text = itemArray[indexPath.row];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
