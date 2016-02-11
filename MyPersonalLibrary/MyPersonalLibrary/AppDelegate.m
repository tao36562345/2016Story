//
//  AppDelegate.m
//  MyPersonalLibrary
//
//  Created by dengtao on 16/2/3.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "AppDelegate.h"
#import "YDCrashHandler.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)installYDCrashHandler
{
    InstallCrashExceptionHandler();
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if (bYDInstallCrashHandler) {
        [self performSelector:@selector(installYDCrashHandler)
                   withObject:nil
                   afterDelay:0];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if (![YDConfigurationHelper getBoolValueForConfigurationKey:bYDFirstLaunch]) {
        [YDConfigurationHelper setApplicationStartupDefaults];
    }
    
    if (bYDActivateGPSOnStartUp)
    {
        // Start your CLLocationManager here if you're application needs the GPS
    }
    
    if (bYDRegistrationRequired && ![YDConfigurationHelper getBoolValueForConfigurationKey:bYDRegistered])
    {
        // Create an instance of your RegistrationViewController
        self.registrationVC = [[YDRegistrationViewController alloc] init];
        // Set the delegate
        self.registrationVC.delegate = self;
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.rootViewController = _registrationVC;
        self.window.backgroundColor = [UIColor clearColor];
        [self.window makeKeyAndVisible];
    } else {
        // you arrive here if either the registration is not required or yet achieved
        if (bYDLoginRequired) {
            self.loginVC = [[YDLoginViewController alloc] init];
            self.loginVC.delegate = self;
            self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            self.window.rootViewController = _loginVC;
            self.window.backgroundColor = [UIColor clearColor];
            [self.window makeKeyAndVisible];
        } else {
            self.viewController = [[ViewController alloc] init];
            self.window.rootViewController = self.viewController;
            [self.window makeKeyAndVisible];
        }
    }
    
    return YES;
}

#pragma Registration Delegates
- (void)registeredWithError
{
    // called from RegistrationViewController if registration failed
}

- (void)registeredWithSuccess
{
    // called from RegistrationViewController if the registration with success
    if (bYDShowLoginAfterRegistration) {
        self.loginVC = [[YDLoginViewController alloc] init];
        self.loginVC.delegate = self;
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.rootViewController = self.loginVC;
        [self.window makeKeyAndVisible];
    } else {
        self.viewController = [[ViewController alloc] init];
        self.window.rootViewController = self.viewController;
        [self.window makeKeyAndVisible];
    }
}

- (void)cancelRegistration
{
    // called from RegistrationViewController if cancel is pressed
}

#pragma Login delegates
- (void)loginWithSuccess
{
    // called when login with success
    self.viewController = [[ViewController alloc] init];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
}

- (void)loginWithError
{
    // called when login with error
}

- (void)loginCancelled
{
    // called when login is cancelled
}
@end
