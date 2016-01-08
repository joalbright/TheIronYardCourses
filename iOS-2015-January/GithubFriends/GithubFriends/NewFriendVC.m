//
//  NewFriendVC.m
//  GithubFriends
//
//  Created by Jo Albright on 1/8/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

#import "NewFriendVC.h"

@interface NewFriendVC ()

@end

@implementation NewFriendVC
{
    UITextField * usernameField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    usernameField = [[UITextField alloc] initWithFrame:CGRectMake(10, 60, 300, 40)];
    usernameField.placeholder = @"Username";
    [self.view addSubview:usernameField];
    
    UIButton * saveFriend = [[UIButton alloc] initWithFrame:CGRectMake(10, 110, 300, 40)];
    [saveFriend setTitle:@"Git User" forState:UIControlStateNormal];
    [saveFriend addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveFriend];
    
    UIButton * cancel = [[UIButton alloc] initWithFrame:CGRectMake(10, 160, 300, 40)];
    [cancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:cancel];
    
}

- (void)save {
    
    NSString * username = usernameField.text;
    
    NSString * urlString = [NSString stringWithFormat:@"https://api.github.com/users/%@",username];
    NSURL * url = [NSURL URLWithString:urlString];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary * userInfo = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    
    [self.friends addObject:userInfo];
    
    [self cancel];
    
}

- (void)cancel {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
