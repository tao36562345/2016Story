//
//  ViewController.m
//  SMSDemo
//
//  Created by badman on 16/4/2.
//  Copyright © 2016年 dengtao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<MFMessageComposeViewControllerDelegate>
{
    UITextField *textField;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, 200, 40)];
    textField.placeholder = @"请输入内容";
    [self.view addSubview:textField];
    
    UIButton *sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(textField.frame)+10, 100, 50, 40)];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendSMS:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sendSMS:(UIButton *)sender
{
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    
    if ([MFMessageComposeViewController canSendText])
    {
        controller.body = textField.text;
        controller.recipients = @[@"phoneNumber"];
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:^{
        if (result == MessageComposeResultCancelled) {
            NSLog(@"Cancelled");
        } else if (result == MessageComposeResultSent) {
            NSLog(@"Sented");
        } else {
            NSLog(@"Failed");
        }
    }];
}
@end
