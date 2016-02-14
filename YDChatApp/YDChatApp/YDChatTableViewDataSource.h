//
//  YDChatTableViewDataSource.h
//  YDChatApp
//
//  Created by badman on 16/2/14.
//  Copyright © 2016年 dengtao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YDChatData;
@class YDChatTableView;

@protocol YDChatTableViewDataSource <NSObject>

- (NSInteger)rowForChatTable:(YDChatTableView *)tableView;
- (YDChatData *)chatTableView:(YDChatTableView *)tableView dataForRow:(NSInteger)row;

@end
