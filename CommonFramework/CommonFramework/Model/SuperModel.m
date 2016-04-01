//
//  SuperModel.m
//  CommonFramework
//
//  Created by dengtao on 16/3/29.
//  Copyright © 2016年 shengzhong. All rights reserved.
//

#import "SuperModel.h"

@implementation SuperModel

#pragma mark - MTLJSONSerializing
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return nil;
}

#pragma mark - MTLFMDBSerializing
+ (NSDictionary *)FMDBColumnsByPropertyKey
{
    return nil;
}

+ (NSArray *)FMDBPrimaryKeys
{
    return nil;
}

+ (NSString *)FMDBTableName {
    return nil;
}
@end
