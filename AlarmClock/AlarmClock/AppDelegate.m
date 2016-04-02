//
//  AppDelegate.m
//  AlarmClock
//
//  Created by badman on 16/4/2.
//  Copyright © 2016年 dengtao. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = [[ViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    application.applicationIconBadgeNumber = 0;
    // Handle launching from a notification
    UILocalNotification *localNotif = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    if (localNotif) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:[[localNotif userInfo] valueForKey:@"msg"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    // Handle the notification when the app is running
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:[[notification userInfo] valueForKey:@"msg"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}

@end
