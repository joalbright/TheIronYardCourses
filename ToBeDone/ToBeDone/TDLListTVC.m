//
//  TDLListTVC.m
//  ToBeDone
//
//  Created by Jo Albright on 4/8/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "TDLListTVC.h"

#import "TDLCell.h"

#import "MOVE.h"

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
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary * listItem = listItems[indexPath.row];
    
//    cell.backgroundColor = priorityColors[[listItem[@"priority"] intValue]];
    
    cell.bgView.backgroundColor = priorityColors[[listItem[@"priority"] intValue]];
    
    if([listItem[@"priority"] intValue] == 0)
    {
        cell.strikeThrough.alpha = 1;
        cell.circleButton.alpha = 0;
    } else {
        cell.strikeThrough.alpha = 0;
        cell.circleButton.alpha = 1;
    }
    
    cell.nameLabel.text = listItem[@"name"];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeCell:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [cell addGestureRecognizer:swipeLeft];
    
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeCell:)];
    
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    [cell addGestureRecognizer:swipeRight];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // get cell from tableview at row
    TDLCell *cell = (TDLCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    // if( ) return;
    
    // set cell background to the done color
    cell.bgView.backgroundColor = priorityColors[0];
    cell.strikeThrough.alpha = 1;
    cell.circleButton.alpha = 0;
    
    // create new dictionary with the done priority
    NSDictionary * updateListItem = @{
        @"name" : listItems[indexPath.row][@"name"],
        @"priority" : @0
    };
    
    // remove old dictionary for cell
    [listItems removeObjectAtIndex:indexPath.row];
    
    // add new dictionary for cell
    [listItems insertObject:updateListItem atIndex:indexPath.row];
}

- (void)swipeCell:(UISwipeGestureRecognizer *)gesture
{
//    NSLog(@"%lu",gesture.direction);
    
    TDLCell * cell = (TDLCell *)gesture.view;
    
    NSInteger index = [self.tableView indexPathForCell:cell].row;
    
    // cell = dictionary
    
    switch (gesture.direction)
    {
        case 1: // right
            [MOVE animateView:cell.bgView properties:@{@"x":@10,@"duration":@0.5}];
            [cell hideCircleButtons];
            break;
            
        case 2: // left
            [MOVE animateView:cell.bgView properties:@{@"x":@-140,@"duration":@0.5}];
            [cell showCircleButtons];
            break;
            
        default:
            break;
    }
}

- (BOOL)prefersStatusBarHidden { return YES; }

@end
