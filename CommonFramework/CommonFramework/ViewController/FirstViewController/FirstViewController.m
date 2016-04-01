//
//  FirstViewController.m
//  CommonFramework
//
//  Created by dengtao on 16/3/30.
//  Copyright © 2016年 shengzhong. All rights reserved.
//

#import "FirstViewController.h"
#import "ViewController.h"

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
    [button setTitle:@"跳转" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonClick:(UIButton *)sender
{
    ViewController *vc = [[ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tabBarController.tabBar setHidden:NO];
}
@end
