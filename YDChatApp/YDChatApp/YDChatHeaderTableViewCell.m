//
//  YDChatHeaderTableViewCell.m
//  YDChatApp
//
//  Created by dengtao on 16/2/15.
//  Copyright © 2016年 dengtao. All rights reserved.
//

#import "YDChatHeaderTableViewCell.h"

@interface YDChatHeaderTableViewCell()

@property (nonatomic, retain) UILabel *label;

@end

@implementation YDChatHeaderTableViewCell

+ (CGFloat)height
{
    return 30.0;
}

- (void)setDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSString *text = [dateFormatter stringFromDate:date];
    
    if (self.label) {
        self.label.text = text;
        return;
    }
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, [YDChatHeaderTableViewCell height])];
    self.label.text = text;
    self.label.font = [UIFont boldSystemFontOfSize:12];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.shadowOffset = CGSizeMake(0, 1);
    self.label.shadowColor = [UIColor whiteColor];
    self.label.textColor = [UIColor darkGrayColor];
    self.label.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.label];
}

@end
