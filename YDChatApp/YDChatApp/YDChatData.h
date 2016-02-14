//
//  YDChatData.h
//  YDChatApp
//
//  Created by badman on 16/2/14.
//  Copyright © 2016年 dengtao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class YDChatUser;

typedef NS_ENUM(NSInteger, YDChatType) {
    ChatTypeMine = 0,
    ChatTypeSomeone = 1,
};

@interface YDChatData : NSObject

@property (nonatomic, readonly) YDChatType type;
@property (nonatomic, readonly, strong) NSDate *date;
@property (nonatomic, readonly, strong) UIView *view;
@property (nonatomic, readonly) UIEdgeInsets insets;
@property (nonatomic, strong) YDChatUser *chatUser;

// custom initializers
+ (id)dataWithText:(NSString *)text
              date:(NSDate *)date
              type:(YDChatType)type
           andUser:(YDChatUser *)_user;

+ (id)dataWithImage:(UIImage *)image
               date:(NSDate *)date
               type:(YDChatType)type
            andUser:(YDChatUser *)_user;

+ (id)dataWithView:(UIView *)view
              date:(NSDate *)date
              type:(YDChatType)type
           andUser:(YDChatUser *)_user
            insets:(UIEdgeInsets)insets;

@end
