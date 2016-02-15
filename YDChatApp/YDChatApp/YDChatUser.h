//
//  YDChatUser.h
//  YDChatApp
//
//  Created by dengtao on 16/2/15.
//  Copyright © 2016年 dengtao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YDChatUser : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) UIImage *avatar;

- (id)initWithUsername:(NSString *)user avatarImage:(UIImage *)image;

@end
