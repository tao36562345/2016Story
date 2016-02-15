//
//  YDChatTableView.m
//  YDChatApp
//
//  Created by badman on 16/2/14.
//  Copyright © 2016年 dengtao. All rights reserved.
//

#import "YDChatTableView.h"
#import "YDChatData.h"
#import "YDChatHeaderTableViewCell.h"

@interface YDChatTableView() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray *bubbleSection;

@end

@implementation YDChatTableView

- (void)initializer
{
    self.backgroundColor = [UIColor clearColor];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.delegate = self;
    self.dataSource = self;
    // the snap interval in seconds implements a headerview to seperate chats
    self.snapInterval = 60 * 60 * 24;   // one day
    self.typingBubble = ChatBubbleTypingTypeNobody;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        [self initializer];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initializer];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initializer];
    }
    return self;
}

#pragma mark - Override
- (void)reloadData
{
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.bubbleSection = nil;
    int count = 0;
    self.bubbleSection = [[NSMutableArray alloc] init];
    if (self.chatDataSource && (count = [self.chatDataSource rowForChatTable:self]) > 0)
    {
        NSMutableArray *bubbleData = [[NSMutableArray alloc] initWithCapacity:count];
        
        for (int i = 0; i < count; i++) {
            NSObject *object = [self.chatDataSource chatTableView:self dataForRow:i];
            assert([object isKindOfClass:[YDChatData class]]);
            [bubbleData addObject:object];
        }
        
        [bubbleData sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            YDChatData *bubbleData1 = (YDChatData *)obj1;
            YDChatData *bubbleData2 = (YDChatData *)obj2;
            
            return [bubbleData1.date compare:bubbleData2.date];
        }];
        
        NSDate *last = [NSDate dateWithTimeIntervalSince1970:0];
        NSMutableArray *currentSection = nil;
        
        for (int i = 0; i < count; i++) {
            YDChatData *data = (YDChatData *)[bubbleData objectAtIndex:i];
            if ([data.date timeIntervalSinceDate:last] > self.snapInterval) {
                currentSection = [[NSMutableArray alloc] init];
                [self.bubbleSection addObject:currentSection];
            }
            [currentSection addObject:data];
            last = data.date;
        }
    }
    
    [super reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int result = [self.bubbleSection count];
    if (self.typingBubble != ChatBubbleTypingTypeNobody) {
        result++;
    }
    return result;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section >= [self.bubbleSection count]) {
        return 1;
    }
    return [[self.bubbleSection objectAtIndex:section] count] + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Header
    if (indexPath.row == 0) {
        return [YDChatHeaderTableViewCell height];
    }
    
    YDChatData *data = [[self.bubbleSection objectAtIndex:indexPath.section] objectAtIndex:indexPath.row - 1];
    return MAX(data.insets.top + data.view.frame.size.height + data.insets.bottom, 52);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Header based on snapInterval
    if (indexPath.row == 0) {
        static NSString *cellId = @"HeaderCell";
        YDChatHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        YDChatData *data = [[self.bubbleSection objectAtIndex:indexPath.section] objectAtIndex:0];
        
        if (cell == nil) {
            cell = [[YDChatHeaderTableViewCell alloc] init];
        }
        cell.date = data.date;
        return cell;
    }
    
    // Standard
    static NSString *cellId = @"ChatCell";
    YDChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    YDChatData *data = [[self.bubbleSection objectAtIndex:indexPath.section] objectAtIndex:indexPath.row - 1];
    if (cell == nil) {
        cell = [[YDChatTableViewCell alloc] init];
    }
    cell.data = data;
    return cell;
}
@end
