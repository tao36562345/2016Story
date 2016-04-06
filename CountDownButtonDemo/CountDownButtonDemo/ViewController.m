//
//  ViewController.m
//  CountDownButtonDemo
//
//  Created by dengtao on 16/4/6.
//  Copyright © 2016年 shengzhong. All rights reserved.
//

#import "ViewController.h"
#import "DTTCountdownButton.h"

@interface ViewController ()
{
    DTTCountdownButton *button;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    button = [[DTTCountdownButton alloc] initWithSeconds:10 frame:CGRectMake(100, 100, 200, 40)];
    [button setTitle:@"发送验证码" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    [button setDisableStateBackgroundColor:[UIColor orangeColor]];
    
    button.prefixCountTitle = @"请在";
    button.suffixCountTitle = @"后重新发送验证码";
    
    button.beforeCountDown = ^(){
        NSLog(@"beforeCountDown");
        return YES;
    };
    button.countDown = ^(){
        NSLog(@"countDown");
    };
    button.afterCountDownFinish = ^(){
        NSLog(@"afterCountDownFinish");
    };
    
    [self.view addSubview:button];
    
    UIButton *manualStart = [[UIButton alloc] initWithFrame:CGRectMake(50, 200, 100, 40)];
    [manualStart setTitle:@"开始倒计时" forState:UIControlStateNormal];
    [manualStart setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [manualStart addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:manualStart];
    
    UIButton *manualEnd = [[UIButton alloc] initWithFrame:CGRectMake(200, 200, 100, 40)];
    [manualEnd setTitle:@"结束倒计时" forState:UIControlStateNormal];
    [manualEnd setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [manualEnd addTarget:self action:@selector(end:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:manualEnd];
}

- (void)start:(UIButton *)sender
{
    [button manualStartCountDown];
}

- (void)end:(UIButton *)sender
{
    [button manualStopCountDown];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
