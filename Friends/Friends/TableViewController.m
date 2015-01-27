//
//  TableViewController.m
//  Friends
//
//  Created by Jo Albright on 1/22/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

#import "TableViewController.h"

#import <Parse/Parse.h>

@interface TableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *itemTextField;

@end

@implementation TableViewController
{
    NSMutableArray * messages;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [PFUser currentUser].username = @"jo";
    [PFUser currentUser].password = @"password";
    
    [[PFUser currentUser] saveInBackground];
    
    messages = [@[] mutableCopy];
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateMessages) userInfo:nil repeats:YES];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)updateMessages {
    
    PFQuery * messageQuery = [PFQuery queryWithClassName:@"Message"];
    
    [messageQuery orderByDescending:@"createdAt"];
    //    [messageQuery whereKey:@"owner" equalTo:[PFUser currentUser]];
    [messageQuery includeKey:@"owner"];
    
    [messageQuery findObjectsInBackgroundWithBlock:^(NSArray * objects, NSError * error) {
        
        if (objects.count > 0) {
            
            messages = [objects mutableCopy];
            
            //            NSLog(@"found %@",messages);
            
            [self.tableView reloadData];
            
        }
        
    }];
    
}

- (IBAction)addItem:(id)sender {

    PFObject * newMessage = [PFObject objectWithClassName:@"Message"];
    
    newMessage[@"text"] = self.itemTextField.text;
    newMessage[@"owner"] = [PFUser currentUser];
    
    [newMessage saveInBackground];
    
    self.itemTextField.text = @"";
    
//    [items addObject:newItem];
    [messages insertObject:newMessage atIndex:0];
    
    [self.tableView reloadData];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
//    NSLog(@"items %d",items.count);
    
    return messages.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemCell" forIndexPath:indexPath];
    
    PFObject * message = messages[indexPath.row];
    PFUser * owner = message[@"owner"];
    
    cell.textLabel.text = owner.username;
    cell.detailTextLabel.text = message[@"text"];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        PFObject * item = messages[indexPath.row];
        
        [item deleteInBackground];
        
        [messages removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
