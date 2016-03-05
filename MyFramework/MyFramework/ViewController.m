//
//  ViewController.m
//  MyFramework
//
//  Created by dengtao on 16/3/4.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "ViewController.h"
#import "FMDBManager.h"
#import "UserInfoDao.h"
#import "UserInfo.h"

@interface ViewController ()
{
    UITextField *usernameTextField;
    UITextField *ageTextField;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, 200, 30)];
    usernameTextField.placeholder = @"请输入用户名";
    [self.view addSubview:usernameTextField];
    
    ageTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 150, 200, 30)];
    ageTextField.placeholder = @"请输入年龄";
    [self.view addSubview:ageTextField];
    
    UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(ageTextField.frame)+20, 200, 40)];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [saveButton setBackgroundColor:[UIColor blueColor]];
    [saveButton addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 自定义响应方法
- (void)save:(UIButton *)sender
{
    UserInfo *userInfo = [UserInfo new];
    userInfo.username = usernameTextField.text;
    userInfo.age = [ageTextField.text integerValue];
    
    if ([UserInfoDao insertUserInfo:userInfo]) {
        NSLog(@"保存成功");
    } else {
        NSLog(@"保存失败");
    }
}
@end
