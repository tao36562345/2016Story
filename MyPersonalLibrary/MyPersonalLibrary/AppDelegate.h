//
//  AppDelegate.h
//  MyPersonalLibrary
//
//  Created by dengtao on 16/2/3.
//  Copyright © 2016年 dt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDRegistrationViewController.h"
#import "YDLoginViewController.h"

@class ViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate, YDLoginViewControllerDelegate, YDRegistrationViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) YDLoginViewController *loginVC;
@property (strong, nonatomic) YDRegistrationViewController *registrationVC;

@end

