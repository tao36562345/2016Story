//
//  YDChatTableView.h
//  YDChatApp
//
//  Created by badman on 16/2/14.
//  Copyright © 2016年 dengtao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YDChatTableViewDataSource.h"
#import "YDChatTableViewCell.h"

// enumerator to identify the bubble type
typedef NS_ENUM(NSInteger, ChatBubbleTypingType)
{
    ChatBubbleTypingTypeNobody = 0,
    ChatBubbleTypingTypeMe = 1,
    ChatBubbleTypingTypeSomebody = 2,
};

@interface YDChatTableView : UITableView

@property (nonatomic, assign) id<YDChatTableViewDataSource> chatDataSource;
@property (nonatomic) NSTimeInterval snapInterval;
@property (nonatomic) ChatBubbleTypingType typingBubble;

@end
