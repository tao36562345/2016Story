//
//  TestModel.m
//  TestFramework
//
//  Created by dengtao on 16/3/29.
//  Copyright © 2016年 shengzhong. All rights reserved.
//

#import "TestModel.h"

//CommonFramework[16049:189587] {
//    appid = wxb4ba3c02aa476ea1;
//    noncestr = 00e269b14f48df33fb74bb20b156ad38;
//    package = "Sign=WXPay";
//    partnerid = 10000100;
//    prepayid = wx2016032915024033dd957fcf0004796715;
//    sign = 2E407BFBF61C94C83E31E78403D9D411;
//    timestamp = 1459234960;
//}

@implementation TestModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{ @"appid"      : @"appid",
              @"noncestr"   : @"noncestr",
              @"package"    : @"package",
              @"partnerid"  : @"partnerid",
              @"prepayid"   : @"prepayid",
              @"sign"       : @"sign",
              @"time"  : @"timestamp",
             };
}

+ (NSDictionary *)FMDBColumnsByPropertyKey
{
    return @{
             @"testModelID": @"testModelID",
             @"appid"      : @"appid",
             @"noncestr"   : @"noncestr",
             @"package"    : @"package",
             @"partnerid"  : @"partnerid",
             @"prepayid"   : @"prepayid",
             @"sign"       : @"sign",
             @"time"       : @"time",
             };
}

+ (NSArray *)FMDBPrimaryKeys
{
    return @[@"testModelID"];
}

+ (NSString *)FMDBTableName {
    return @"TEST_MODEL_TABLE";
}
@end
