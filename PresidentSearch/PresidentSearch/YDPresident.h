//
//  YDPresident.h
//  PresidentSearch
//
//  Created by dengtao on 16/2/16.
//  Copyright © 2016年 dt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDPresident : NSObject
{
    NSString *firstName;
    NSString *lastName;
}

@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;

+ (YDPresident *)presidentWithFirstName:(NSString *)firstName lastName:(NSString *)lastName;

@end
