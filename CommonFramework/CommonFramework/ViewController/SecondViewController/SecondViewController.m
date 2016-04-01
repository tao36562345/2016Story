//
//  SecondViewController.m
//  CommonFramework
//
//  Created by dengtao on 16/3/30.
//  Copyright © 2016年 shengzhong. All rights reserved.
//

#import "SecondViewController.h"
#import "LoginViewController.h"

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
    [button setTitle:@"登录" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonClick:(UIButton *)sender
{
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
    [self presentViewController:nvc animated:YES completion:nil];
}

@end
