//
//  YDConfigurationHelper.m
//  MyPersonalLibrary
//
//  Created by dengtao on 16/2/3.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "YDConfigurationHelper.h"

@implementation YDConfigurationHelper

+ (void)setApplicationStartupDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    [defaults setBool:NO forKey:bYDFirstLaunch];
    [defaults setBool:NO forKey:bYDAuthenticated];
    [defaults synchronize];
}

+ (BOOL)getBoolValueForConfigurationKey:(NSString *)_objectkey
{
    // create an instance of NSUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    return [defaults boolForKey:_objectkey];
}

+ (NSString *)getStringValueForConfigurationKey:(NSString *)_objectkey
{
    // create an instance of NSUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];     // let's make sure the object is synchronized
    
    if ([defaults stringForKey:_objectkey] == nil) {
        // I don't want a (null) returned
        return @"";
    } else {
        return [defaults stringForKey:_objectkey];
    }
}

+ (void)setBoolValueForConfigurationKey:(NSString *)_objectkey
                              withValue:(BOOL)_boolvalue
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];     // let's make sure the object is synchronized
    [defaults setBool:_boolvalue forKey:_objectkey];
    [defaults synchronize];
}

+ (void)setStringValueForConfigurationKey:(NSString *)_objectkey
                                withValue:(NSString *)_value
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    [defaults setValue:_value forKey:_objectkey];
    [defaults synchronize];
}
@end
