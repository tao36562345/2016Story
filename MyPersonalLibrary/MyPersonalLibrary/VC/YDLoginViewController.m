//
//  YDLoginViewController.m
//  MyPersonalLibrary
//
//  Created by badman on 16/2/10.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "YDLoginViewController.h"
#import "NSString+MD5.h"
#import "KeychainItemWrapper.h"

@interface YDLoginViewController () {
    UILabel *topLabel;
    UIButton *loginButton;
    UIButton *cancelButton;
}

@end

@implementation YDLoginViewController

@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT)];
    topLabel.text = @"注册";
    [self.view addSubview:topLabel];
    
    self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(topLabel.frame)+20, SCREEN_WIDTH-40, 30)];
    self.nameField.placeholder = @"请输入用户名";
    
    UIView *nameFieldLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(nameFieldLeftView.frame), 30)];
    nameLabel.text = @"用户名：";
    [nameFieldLeftView addSubview:nameLabel];
    self.nameField.leftView = nameFieldLeftView;
    self.nameField.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:self.nameField];
    
    self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.nameField.frame)+20, SCREEN_WIDTH-40, 30)];
    self.passwordField.placeholder = @"请输入密码";
    [self.passwordField setSecureTextEntry:YES];
    
    UIView *passwordFieldLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(passwordFieldLeftView.frame), 30)];
    passwordLabel.text = @"密码：";
    [passwordFieldLeftView addSubview:passwordLabel];
    self.passwordField.leftView = passwordFieldLeftView;
    self.passwordField.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:self.passwordField];
    
    loginButton = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.passwordField.frame)+50, SCREEN_WIDTH-40, 40)];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setBackgroundColor:[UIColor blueColor]];
    [loginButton addTarget:self
                     action:@selector(loginUser:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(loginButton.frame)+20, CGRectGetWidth(loginButton.frame), 40)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton setBackgroundColor:[UIColor blueColor]];
    [cancelButton addTarget:self
                    action:@selector(cancelLogin:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginUser:(UIButton *)sender
{
    if (([self.nameField.text length] == 0) ||
        ([self.passwordField.text length] == 0))
    {
        [self showErrorWithMessage:@"Both fields are mandatory!"];
    } else {
        KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"YDAPPNAME"
                                                                            accessGroup:nil];
        if ([self.nameField.text isEqualToString:[keychain objectForKey:(__bridge id)kSecAttrAccount]])
        {
            if ([[self.passwordField.text MD5] isEqualToString:[keychain objectForKey:(__bridge id)kSecValueData]])
            {
                [self.delegate loginWithSuccess];
            } else {
                [self showErrorWithMessage:@"Name not correct."];
            }
        }
    }
}

- (void)cancelLogin:(UIButton *)sender
{
    [self.delegate loginCancelled];
}

- (void)showErrorWithMessage:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

@end
