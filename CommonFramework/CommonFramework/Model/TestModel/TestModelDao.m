//
//  TestModelDao.m
//  CommonFramework
//
//  Created by dengtao on 16/4/1.
//  Copyright © 2016年 shengzhong. All rights reserved.
//

#import "TestModelDao.h"
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

@implementation TestModelDao

static TestModelDao *dao;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dao = [[TestModelDao alloc] init];
    });
    return dao;
}

- (instancetype)init
{
    self = [super self];
    
    if (self) {
        if (![self createTable]) {
            NSLog(@"test信息表创建失败!");
        };
    }
    return self;
}

// 创建用户信息表
- (BOOL)createTable
{
    NSString *createTableSql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@'('%@' TEXT PRIMARY KEY, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT)", TEST_MODEL_TABLE, TEST_MODEL_TABLE_ID, APPID, NONCESTR, PACKAGE, PARTNERID, PREPAYID, SIGN, TIME];
    return [[FMDBManager shareInstance] executeUpdate:createTableSql];
}
@end
