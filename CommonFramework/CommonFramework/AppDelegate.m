//
//  AppDelegate.m
//  CommonFramework
//
//  Created by dengtao on 16/3/28.
//  Copyright © 2016年 shengzhong. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "FMDBManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[RootViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    /*------------初始化数据库，并创建需要的表--------------*/
    FMDBManager *manager = [FMDBManager shareInstance];
    // 需要创建对应表的类名数组，根据提供的类名调用类中的createTable方法创建对应的表。
    NSArray *tableNameArray = @[@"TestModel"];
    [manager createTables:tableNameArray];
    /*------------初始化数据库，并创建需要的表--------------*/
    
    // 开始监听网络状态
    [[PDHttpTool sharedHttpTool] monitorNetworkStatus];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
