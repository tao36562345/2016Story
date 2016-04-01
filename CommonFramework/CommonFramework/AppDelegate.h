//
//  AppDelegate.h
//  CommonFramework
//
//  Created by dengtao on 16/3/28.
//  Copyright © 2016年 shengzhong. All rights reserved.
//

#import <UIKit/UIKit.h>

//全局 AppDelegate
#define theApp ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

