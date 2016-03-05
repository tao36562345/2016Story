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

+ (BOOL)createTable
{
    NSString *createTableSql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@'('%@' INTEGER PRIMARY KEY AUTOINCREMENT, '%@' TEXT, '%@' INTEGER)", USER_INFO_TABLE, USER_INFO_PRIMARY_KEY, USER_NAME, USER_AGE];
    return [[FMDBManager shareInstance] executeUpdate:createTableSql];
}

+ (BOOL)insertUserInfo:(UserInfo *)userInfo
{
    [UserInfoDao createTable];
    /* 第一种保存方式
    NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO %@(%@,%@) VALUES('%@', %ld)", USER_INFO_TABLE, USER_NAME, USER_AGE, userInfo.username, userInfo.age];
    return [[FMDBManager shareInstance] executeUpdate:insertSql];
    */
    
    /* 第二种保存方式 */
    NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO %@(%@,%@) VALUES(?, ?)", USER_INFO_TABLE, USER_NAME, USER_AGE];
    NSArray *params = @[userInfo.username, @(userInfo.age)];
    return [[FMDBManager shareInstance] executeUpdate:insertSql withArgumentsInArray:params];
}
@end
