//
//  UserInfoDao.m
//  MyFramework
//
//  Created by badman on 16/3/5.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "UserInfoDao.h"
#import "FMDBManager.h"
#import "UserInfo.h"

#define USER_INFO_TABLE @"USER_INFO_TABLE"
#define USER_INFO_PRIMARY_KEY @"USER_INFO_PRIMARY_KEY"
#define USER_NAME @"USER_NAME"
#define USER_AGE @"USER_AGE"

@implementation UserInfoDao

static UserInfoDao *userInfoDao;

- (instancetype)init
{
    self = [super self];
    
    if (self) {
        if (![self createTable]) {
            NSLog(@"用户信息表创建失败!");
        };
    }
    return self;
}

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfoDao = [[UserInfoDao alloc] init];
    });
    return userInfoDao;
}

// 创建用户信息表
- (BOOL)createTable
{
    NSString *createTableSql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@'('%@' INTEGER PRIMARY KEY AUTOINCREMENT, '%@' TEXT, '%@' INTEGER)", USER_INFO_TABLE, USER_INFO_PRIMARY_KEY, USER_NAME, USER_AGE];
    return [[FMDBManager shareInstance] executeUpdate:createTableSql];
}

// 保存用户信息
- (BOOL)insertUserInfo:(UserInfo *)userInfo
{
    /* 第一种保存方式
    NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO %@(%@,%@) VALUES('%@', %ld)", USER_INFO_TABLE, USER_NAME, USER_AGE, userInfo.username, userInfo.age];
    return [[FMDBManager shareInstance] executeUpdate:insertSql];
    */
    
    /* 第二种保存方式 */
    NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO %@(%@,%@) VALUES(?, ?)", USER_INFO_TABLE, USER_NAME, USER_AGE];
    NSArray *params = @[userInfo.username, @(userInfo.age)];
    return [[FMDBManager shareInstance] executeUpdate:insertSql withArgumentsInArray:params];
}

// 获取所有用户信息
- (NSArray *)allUsers
{
    NSString *sql = [NSString stringWithFormat:@"SELECT %@, %@ FROM %@", USER_NAME, USER_AGE, USER_INFO_TABLE];
    NSArray *resultArray = [[FMDBManager shareInstance] executeQuery:sql];
    
    NSMutableArray *users = [[NSMutableArray alloc] init];
    for (NSDictionary *tempDic in resultArray) {
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.username = [tempDic objectForKey:USER_NAME];
        NSNumber *age = (NSNumber *)[tempDic objectForKey:USER_AGE];
        userInfo.age = [age integerValue];
        [users addObject:userInfo];
    }
    return [users copy];
}
@end
