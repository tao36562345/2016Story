//
//  FMDBManager.m
//  MyFramework
//
//  Created by dengtao on 16/3/4.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "FMDBManager.h"
#import "FMDB.h"

@interface FMDBManager()
{
    FMDatabase *db;
}

@end

@implementation FMDBManager

static FMDBManager *manager = nil;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FMDBManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        db = [[FMDatabase alloc] initWithPath:@"tmp/tmp.db"];
    }
    return self;
}

- (BOOL)executeUpdate:(NSString *)sql
{
    BOOL isSuccess = NO;
    if ([db open])
    {
        isSuccess = [db executeUpdate:sql];
        [db close];
    }
    return isSuccess;
}

- (BOOL)executeUpdate:(NSString *)sql withArgumentsInArray:(NSArray *)params
{
    BOOL isSuccess = NO;
    if ([db open])
    {
        isSuccess = [db executeUpdate:sql withArgumentsInArray:params];
        [db close];
    }
    return isSuccess;
}

- (NSArray *)executeQuery:(NSString *)sql
{
    NSMutableArray *resultMutableArray = [NSMutableArray new];
    if ([db open])
    {
        FMResultSet *resultSet = [db executeQuery:sql];
        if (resultSet)
        {
            while ([resultSet next])
            {
                [resultMutableArray addObject:[resultSet resultDictionary]];
            }
            [db close];
        } else
        {
            NSLog(@"database error: ===========>%d%@", [db lastErrorCode], [db lastErrorMessage]);
        }
    }
    return [resultMutableArray copy];
}
@end
