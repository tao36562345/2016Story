//
//  FMDBManager.h
//  MyFramework
//
//  Created by dengtao on 16/3/4.
//  Copyright © 2016年 dt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMDBManager : NSObject

+ (instancetype)shareInstance;

- (BOOL)executeUpdate:(NSString *)sql;
- (BOOL)executeUpdate:(NSString *)sql withArgumentsInArray:(NSArray *)params;

- (NSArray *)executeQuery:(NSString *)sql;
@end
