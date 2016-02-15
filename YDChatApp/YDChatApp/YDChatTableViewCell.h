//
//  YDChatTableViewCell.h
//  YDChatApp
//
//  Created by dengtao on 16/2/15.
//  Copyright © 2016年 dengtao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YDChatData.h"

@interface YDChatTableViewCell : UITableViewCell

@property (nonatomic, strong) YDChatData *data;

- (void)setData:(YDChatData *)data;

@end
