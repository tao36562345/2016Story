//
//  YDLoginViewController.h
//  MyPersonalLibrary
//
//  Created by badman on 16/2/10.
//  Copyright © 2016年 dt. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YDLoginViewControllerDelegate <NSObject>

- (void)loginWithSuccess;
- (void)loginWithError;
- (void)loginCancelled;

@end

@interface YDLoginViewController : UIViewController

@property (strong, nonatomic) UITextField *nameField;
@property (nonatomic, strong) UITextField *passwordField;

@property (nonatomic, assign) id<YDLoginViewControllerDelegate> delegate;

- (void)loginUser:(UIButton *)sender;
- (void)cancelLogin:(UIButton *)sender;

@end
