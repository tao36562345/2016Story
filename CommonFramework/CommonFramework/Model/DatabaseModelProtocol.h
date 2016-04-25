//
//  DatabaseModelProtocol.h
//  CommonFramework
//
//  Created by dengtao on 16/4/5.
//  Copyright © 2016年 shengzhong. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 所有需要保存到数据库的Model需要遵循此协议，实现创建对应表的方法
 */
@protocol DatabaseModelProtocol <NSObject>

@required
- (void)createTable;

@end
