//
//  YDConfigurationHelper.h
//  MyPersonalLibrary
//
//  Created by dengtao on 16/2/3.
//  Copyright © 2016年 dt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDConfigurationHelper : NSObject

+ (void)setApplicationStartupDefaults;

+ (BOOL)getBoolValueForConfigurationKey:(NSString *)_objectkey;

+ (NSString *)getStringValueForConfigurationKey:(NSString *)_objectkey;

+ (void)setBoolValueForConfigurationKey:(NSString *)_objectkey
                              withValue:(BOOL)_boolvalue;

+ (void)setStringValueForConfigurationKey:(NSString *)_objectkey
                                withValue:(NSString *)_value;
@end
