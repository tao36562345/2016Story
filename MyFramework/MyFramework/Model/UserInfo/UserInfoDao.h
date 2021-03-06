//
//  UserInfoDao.h
//  MyFramework
//
//  Created by badman on 16/3/5.
//  Copyright © 2016年 dt. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserInfo;

@interface UserInfoDao : NSObject

+ (instancetype)shareInstance;

- (BOOL)insertUserInfo:(UserInfo *)userInfo;
- (NSArray *)allUsers;

@end
