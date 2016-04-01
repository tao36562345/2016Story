//
//  FMDBManager.m
//  MyFramework
//
//  Created by dengtao on 16/3/4.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "FMDBManager.h"
#import "MTLFMDBAdapter.h"

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
        NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString* dbpath = [docsdir stringByAppendingPathComponent:@"app.sqlite"];
        db = [[FMDatabase alloc] initWithPath:dbpath];
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

- (BOOL)insertInstance:(id)instance
{
    BOOL isSuccess = NO;
    if ([db open])
    {
        NSString *stmt = [MTLFMDBAdapter insertStatementForModel:instance];
        NSArray *params = [MTLFMDBAdapter columnValues:instance];
    
        isSuccess = [db executeUpdate:stmt withArgumentsInArray:params];
        [db close];
    }
    return isSuccess;
}

- (BOOL)updateInstance:(id)instance
{
    BOOL isSuccess = NO;
    if ([db open])
    {
        NSString *stmt = [MTLFMDBAdapter updateStatementForModel:instance];
        NSArray *columnValues = [MTLFMDBAdapter columnValues:instance];
        NSArray *keysValues = [MTLFMDBAdapter primaryKeysValues:instance];
        
        NSMutableArray *params = [NSMutableArray array];
        [params addObjectsFromArray:columnValues];
        [params addObjectsFromArray:keysValues];
        
        isSuccess = [db executeUpdate:stmt withArgumentsInArray:[params copy]];
        [db close];
    }
    return isSuccess;
}

- (BOOL)deleteInstance:(id)instance
{
    BOOL isSuccess = NO;
    if ([db open])
    {
        NSString *stmt = [MTLFMDBAdapter deleteStatementForModel:instance];
        NSArray *keysValues = [MTLFMDBAdapter primaryKeysValues:instance];
        
        isSuccess = [db executeUpdate:stmt withArgumentsInArray:keysValues];
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

- (NSArray *)executeQueryToArray:(NSString *)sql withClass:(Class)class
{
    NSMutableArray *resultMutableArray = [NSMutableArray new];
    if ([db open])
    {
        FMResultSet *resultSet = [db executeQuery:sql];
        if (resultSet)
        {
            while ([resultSet next])
            {
                NSError *error = nil;
                id resultUser = [MTLFMDBAdapter modelOfClass:class fromFMResultSet:resultSet error:&error];
                [resultMutableArray addObject:resultUser];
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
