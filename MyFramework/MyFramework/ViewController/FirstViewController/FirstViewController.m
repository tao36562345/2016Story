//
//  FirstViewController.m
//  MyFramework
//
//  Created by dengtao on 16/3/7.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "FirstViewController.h"
#import "UserInfoDao.h"
#import "UserInfo.h"
#import "AddUserViewController.h"

@interface FirstViewController()
{
    NSArray *userArray;
}

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"用户列表";
    UIButton *addUserButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [addUserButton addTarget:self action:@selector(toAddUserViewController:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addUserButton];
    
    userArray = [[UserInfoDao shareInstance] allUsers];
    if (!userArray) {
        userArray = @[];
    }
}

#pragma mark - 响应方法
// 跳转到添加用户界面
- (void)toAddUserViewController:(id)sender
{
    AddUserViewController *addUserViewController = [AddUserViewController new];
    [self.navigationController pushViewController:addUserViewController animated:YES];
}

#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return userArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    UserInfo *userInfo = userArray[indexPath.row];
    cell.textLabel.text = userInfo.username;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"年龄：%ld", userInfo.age];
    
    return cell;
}

@end
