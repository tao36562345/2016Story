//
//  StateView.h
//  GoodPeople
//
//  Created by yujiuyin on 15/9/6.
//  Copyright (c) 2015年 yujiuyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StateBarView : UIView{
    UILabel *contentLab;
}


+ (StateBarView *)sharedInstance;

- (void)showStateBarView:(NSString *)showStr;
- (void)removeStateBarView;

@end
