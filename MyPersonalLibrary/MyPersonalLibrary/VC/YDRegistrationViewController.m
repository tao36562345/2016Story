//
//  YDRegistrationViewController.m
//  MyPersonalLibrary
//
//  Created by dengtao on 16/2/3.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "YDRegistrationViewController.h"
#import "NSString+MD5.h"
#import "KeychainItemWrapper.h"

@interface YDRegistrationViewController ()
{
    UILabel     *topLabel;
    UITextField *nameField;
    UITextField *passwordField;
    UIButton    *registButton;
    UIButton    *loginButton;
}

@end

@implementation YDRegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT)];
    topLabel.text = @"注册";
    [self.view addSubview:topLabel];
    
    nameField = [[UITextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(topLabel.frame)+20, SCREEN_WIDTH-40, 30)];
    nameField.placeholder = @"请输入用户名";
    
    UIView *nameFieldLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(nameFieldLeftView.frame), 30)];
    nameLabel.text = @"用户名：";
    [nameFieldLeftView addSubview:nameLabel];
    nameField.leftView = nameFieldLeftView;
    nameField.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:nameField];
    
    passwordField = [[UITextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(nameField.frame)+20, SCREEN_WIDTH-40, 30)];
    passwordField.placeholder = @"请输入密码";
    [passwordField setSecureTextEntry:YES];
    
    UIView *passwordFieldLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(passwordFieldLeftView.frame), 30)];
    passwordLabel.text = @"密码：";
    [passwordFieldLeftView addSubview:passwordLabel];
    passwordField.leftView = passwordFieldLeftView;
    passwordField.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:passwordField];
    
    registButton = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(passwordField.frame)+50, SCREEN_WIDTH-40, 40)];
    [registButton setTitle:@"注册" forState:UIControlStateNormal];
    [registButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registButton setBackgroundColor:[UIColor blueColor]];
    [registButton addTarget:self
                     action:@selector(registerUser:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registButton];
    
    loginButton = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(registButton.frame)+20, CGRectGetWidth(registButton.frame), 40)];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setBackgroundColor:[UIColor blueColor]];
    [loginButton addTarget:self
                    action:@selector(cancelRegistration:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registerUser:(UIButton *)sender
{
    if (([nameField.text length] == 0) ||
        ([passwordField.text length] == 0)) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Both fields are mandatory"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
        [alert show];
    } else {
        KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"YDAPPNAME"
                                                                            accessGroup:nil];
        [keychain setObject:nameField.text
                     forKey:(__bridge id)kSecAttrAccount];
        [keychain setObject:[passwordField.text MD5]
                     forKey:(__bridge id)kSecValueData];
        
        // reading back a value from the keychain for comparison
        // get username [keychain objectForKey:(__bridge id)kSecAttrAccount]);
        // get password [keychain objectForKey:(__bridge id)kSecValueData]);
        [YDConfigurationHelper setBoolValueForConfigurationKey:bYDRegistered
                                                     withValue:YES];
        [self.delegate registeredWithSuccess];
        // or
//        [self.delegate registeredWithError];
    }
}

- (void)cancelRegistration:(UIButton *)sender
{
    [self.delegate cancelRegistration];
}

@end
