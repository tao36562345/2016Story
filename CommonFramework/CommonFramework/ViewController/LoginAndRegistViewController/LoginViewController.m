/************************************************************
 *  * EaseMob CONFIDENTIAL
 * __________________
 * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of EaseMob Technologies.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from EaseMob Technologies.
 */

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "ResetPasswordViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) UITextField *usernameTextField;
@property (strong, nonatomic) UITextField *passwordTextField;
@property (strong, nonatomic) UIButton *registerButton;
@property (strong, nonatomic) UIButton *loginButton;
@property (strong, nonatomic) UISwitch *useIpSwitch;

@end

@implementation LoginViewController

@synthesize usernameTextField = _usernameTextField;
@synthesize passwordTextField = _passwordTextField;
@synthesize registerButton = _registerButton;
@synthesize loginButton = _loginButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置导航栏
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backButton setTitle:@"取消" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setRightBarButtonItem:backItem];
    [self.navigationItem setLeftBarButtonItem:nil];
    
    // 点击空白处收起键盘
    [self setupForDismissKeyboard];
    
    // 加载子视图
    [self loadSubViews];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 加载子视图
- (void)loadSubViews
{
    UIImageView *accountImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20+5, 100, 18, 21)];
    accountImageView.image = [UIImage imageNamed:@"account.png"];
    [self.view addSubview:accountImageView];
    
    _usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(accountImageView.frame)+15, 100, SCREEN_WIDTH - 80, 30)];
    _usernameTextField.delegate = self;
    _usernameTextField.placeholder = @"输入手机号";
    [_usernameTextField setFont:[UIFont systemFontOfSize:15]];
    _usernameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _usernameTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_usernameTextField];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(accountImageView.frame)+17, SCREEN_WIDTH-40, 0.5)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line1];
    
    UIImageView *passwordImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20+5, CGRectGetMaxY(line1.frame)+14, 18, 21)];
    passwordImageView.image = [UIImage imageNamed:@"password.png"];
    [self.view addSubview:passwordImageView];
    
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(passwordImageView.frame)+15, CGRectGetMidY(passwordImageView.frame)-15, SCREEN_WIDTH - 80, 30)];
    _passwordTextField.delegate = self;
    _passwordTextField.placeholder = @"登录密码";
    _passwordTextField.font = [UIFont systemFontOfSize:15];
    _passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
    _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordTextField.secureTextEntry = YES;
    
    [self.view addSubview:_passwordTextField];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(passwordImageView.frame)+17, SCREEN_WIDTH-40, 0.5)];
    line2.backgroundColor = [UIColor lightGrayColor];
    line2.hidden = YES;
    [self.view addSubview:line2];
    
    _loginButton = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(line2.frame)+18, SCREEN_WIDTH-40, 34)];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _loginButton.titleLabel.font = [UIFont systemFontOfSize:15];
    _loginButton.backgroundColor = [UIColor blueColor];
    _loginButton.layer.cornerRadius = 3.0f;
    [_loginButton addTarget:self action:@selector(doLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    
    UIButton *findPasswordButton = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_loginButton.frame)+10, 48, 12)];
    [findPasswordButton setTitle:@"找回密码" forState:UIControlStateNormal];
    [findPasswordButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    findPasswordButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [findPasswordButton addTarget:self action:@selector(toResetPasswordController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:findPasswordButton];
    
    UIButton *toRegistButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_loginButton.frame)-48, CGRectGetMaxY(_loginButton.frame)+10, 48, 12)];
    [toRegistButton setTitle:@"快速注册" forState:UIControlStateNormal];
    [toRegistButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    toRegistButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [toRegistButton addTarget:self action:@selector(toRegistController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:toRegistButton];
    
}

- (void)toRegistController:(UIButton *)sender
{
    RegistViewController *rvc = [[RegistViewController alloc] init];
    [self.navigationController pushViewController:rvc animated:YES];
}

// 跳转到重置密码界面
- (void)toResetPasswordController:(UIButton *)sender
{
    ResetPasswordViewController *rpvc = [[ResetPasswordViewController alloc] init];
    [self.navigationController pushViewController:rpvc animated:YES];
}

//登陆账号
- (void)doLogin:(id)sender {
    
}

#pragma  mark - TextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == _usernameTextField) {
//        _passwordTextField.text = @"";//点击账号框时，密码框内已有内容清空
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _usernameTextField) {
        [_usernameTextField resignFirstResponder];
        [_passwordTextField becomeFirstResponder];
    } else if (textField == _passwordTextField) {
        [_passwordTextField resignFirstResponder];
        [self doLogin:nil];
    }
    return YES;
}

#pragma  mark - private
- (void)saveLastLoginUsername
{
    NSString *username = _usernameTextField.text;
    if (username && username.length > 0) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:username forKey:[NSString stringWithFormat:@"em_lastLogin_%@",kSDKUsername]];
        [ud synchronize];
    }
}

- (NSString*)lastLoginUsername
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *username = [ud objectForKey:[NSString stringWithFormat:@"em_lastLogin_%@",kSDKUsername]];
    if (username && username.length > 0) {
        return username;
    }
    return nil;
}

@end
