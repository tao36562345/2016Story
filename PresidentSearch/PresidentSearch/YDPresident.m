//
//  YDPresident.m
//  PresidentSearch
//
//  Created by dengtao on 16/2/16.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "YDPresident.h"

@implementation YDPresident
@synthesize firstName, lastName;

+ (YDPresident *)presidentWithFirstName:(NSString *)firstName lastName:(NSString *)lastName
{
    YDPresident *president = [[YDPresident alloc] init];
    president.firstName = firstName;
    president.lastName = lastName;
    
    return president;
}

@end
