//
//  TestModel.h
//  TestFramework
//
//  Created by dengtao on 16/3/29.
//  Copyright © 2016年 shengzhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SuperModel.h"

@interface TestModel : SuperModel

@property (nonatomic, copy) NSString *testModelID;
@property (nonatomic, copy) NSString *appid;
@property (nonatomic, copy) NSString *noncestr;
@property (nonatomic, copy) NSString *package;
@property (nonatomic, copy) NSString *partnerid;
@property (nonatomic, copy) NSString *prepayid;
@property (nonatomic, copy) NSString *sign;
@property (nonatomic, assign) NSString *time;

@end
