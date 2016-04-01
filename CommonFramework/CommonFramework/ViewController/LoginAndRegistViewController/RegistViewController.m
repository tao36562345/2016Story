//
//  RegistViewController.m
//  ChatDemo-UI3.0
//
//  Created by dengtao on 16/2/22.
//  Copyright © 2016年 dengtao. All rights reserved.
//

#import "RegistViewController.h"

@interface RegistViewController ()

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupForDismissKeyboard];
    
    
    UIButton *registButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 200, SCREEN_WIDTH-40, 38)];
    [registButton setTitle:@"注册" forState:UIControlStateNormal];
    [registButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registButton setBackgroundColor:[UIColor redColor]];
    registButton.layer.cornerRadius = 3.0f;
    [self.view addSubview:registButton];
    
    UILabel *agreementLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(registButton.frame)+19, CGRectGetMaxY(registButton.frame)+5, CGRectGetWidth(registButton.frame)-38, 40)];
    agreementLabel.font = [UIFont systemFontOfSize:10];
    agreementLabel.numberOfLines = 0;
    [self.view addSubview:agreementLabel];
    
    NSString *agreementString = @"点击上面的“注册”按钮，即表示你同意《XX软件许可及服务协议》";
    NSMutableAttributedString *agreementAttributedString = [[NSMutableAttributedString alloc] initWithString:agreementString];
    NSRange range = [agreementString rangeOfString:@"《XX软件许可及服务协议》"];
    [agreementAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    agreementLabel.attributedText = agreementAttributedString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
