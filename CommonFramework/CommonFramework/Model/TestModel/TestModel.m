//
//  TestModel.m
//  TestFramework
//
//  Created by dengtao on 16/3/29.
//  Copyright © 2016年 shengzhong. All rights reserved.
//

#import "TestModel.h"
#import "FMDBManager.h"

#define TEST_MODEL_TABLE @"TEST_MODEL_TABLE"
#define TEST_MODEL_TABLE_ID @"testModelID"
#define APPID @"appid"
#define NONCESTR @"noncestr"
#define PACKAGE @"package"
#define PARTNERID @"partnerid"
#define PREPAYID @"prepayid"
#define SIGN @"sign"
#define TIME @"time"

@implementation TestModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{ @"appid"      : @"appid",
              @"noncestr"   : @"noncestr",
              @"package"    : @"package",
              @"partnerid"  : @"partnerid",
              @"prepayid"   : @"prepayid",
              @"sign"       : @"sign",
              @"time"  : @"timestamp",
             };
}

+ (NSDictionary *)FMDBColumnsByPropertyKey
{
    return @{
             @"testModelID": @"testModelID",
             @"appid"      : @"appid",
             @"noncestr"   : @"noncestr",
             @"package"    : @"package",
             @"partnerid"  : @"partnerid",
             @"prepayid"   : @"prepayid",
             @"sign"       : @"sign",
             @"time"       : @"time",
             };
}

+ (NSArray *)FMDBPrimaryKeys
{
    return @[@"testModelID"];
}

+ (NSString *)FMDBTableName {
    return @"TEST_MODEL_TABLE";
}

#pragma mark - DatabaseModelProtocol
// 创建用户信息表
- (void)createTable
{
    NSString *createTableSql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@'('%@' TEXT PRIMARY KEY, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT)", TEST_MODEL_TABLE, TEST_MODEL_TABLE_ID, APPID, NONCESTR, PACKAGE, PARTNERID, PREPAYID, SIGN, TIME];
    BOOL flag = [[FMDBManager shareInstance] executeUpdate:createTableSql];
    NSLog(flag ? @"用户信息表创建成功" : @"用户信息表创建失败");
}
@end
