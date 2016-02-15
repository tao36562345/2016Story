//
//  YDChatUser.m
//  YDChatApp
//
//  Created by dengtao on 16/2/15.
//  Copyright © 2016年 dengtao. All rights reserved.
//

#import "YDChatUser.h"

@implementation YDChatUser
@synthesize avatar = _avatar;
@synthesize username = _username;

- (id)initWithUsername:(NSString *)user avatarImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        _avatar = [image copy];
        _username = [user copy];
    }
    
    return self;
}

@end
