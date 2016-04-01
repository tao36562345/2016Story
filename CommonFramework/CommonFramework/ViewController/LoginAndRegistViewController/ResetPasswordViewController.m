//
//  ResetPasswordViewController.m
//  ChatDemo-UI3.0
//
//  Created by dengtao on 16/2/23.
//  Copyright © 2016年 dengtao. All rights reserved.
//

#import "ResetPasswordViewController.h"

@interface ResetPasswordViewController ()

@end

@implementation ResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupForDismissKeyboard];
    
    UIButton *resetButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 260, SCREEN_WIDTH-40, 38)];
    [resetButton setTitle:@"确认" forState:UIControlStateNormal];
    [resetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [resetButton setBackgroundColor:[UIColor blueColor]];
    resetButton.layer.cornerRadius = 3.0f;
    [self.view addSubview:resetButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
