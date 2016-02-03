//
//  YDRegistrationViewController.h
//  MyPersonalLibrary
//
//  Created by dengtao on 16/2/3.
//  Copyright © 2016年 dt. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YDRegistrationViewControllerDelegate <NSObject>

- (void)registeredWithSuccess;
- (void)registeredWithError;
- (void)cancelRegistration;

@end

@interface YDRegistrationViewController : UIViewController

@property (nonatomic, assign) id<YDRegistrationViewControllerDelegate> delegate;


@end
