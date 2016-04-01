//
//  FMDBManager.h
//  MyFramework
//
//  Created by dengtao on 16/3/4.
//  Copyright © 2016年 dt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface FMDBManager : NSObject

+ (instancetype)shareInstance;

/**
 执行增、删、改操作语句
 @param sql 需要执行的操作语句
 @return 操作是否成功
 */
- (BOOL)executeUpdate:(NSString *)sql;

/**
 执行增、删、改操作语句
 @param sql 需要执行的操作语句
 @param params 传入语句的参数
 @return 操作是否成功
 */
- (BOOL)executeUpdate:(NSString *)sql withArgumentsInArray:(NSArray *)params;

/** 
 将实例instance保存到数据库
 @param instance 需要保存的实例
 @return 保存操作是否成功
 */
- (BOOL)insertInstance:(id)instance;

/**
 更新数据库中的实例instance
 @param instance 需要更新的实例
 @return 更新操作是否成功
 */
- (BOOL)updateInstance:(id)instance;

/**
 删除数据库中的实例instance
 @param instance 需要删除的实例
 @return 删除操作是否成功
 */
- (BOOL)deleteInstance:(id)instance;

/**
 执行数据库查询语句
 @param sql SELECT语句
 @return 返回包含有NSDictionary类型的数组
 */
- (NSArray *)executeQuery:(NSString *)sql;

/**
 执行数据库查询语句
 @param sql SELECT语句
 @param class model的类型（将查询结果转换为model）
 @return 返回包含有Class类型的实例数组
 */
- (NSArray *)executeQueryToArray:(NSString *)sql withClass:(Class)class;
@end
