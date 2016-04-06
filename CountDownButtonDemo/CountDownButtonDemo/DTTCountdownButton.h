//
//  DTCountdownButton.h
//  HuiSongHuo-Driver
//
//  Created by dengtao on 15/12/30.
//  Copyright © 2015年 dt. All rights reserved.
//

#import <UIKit/UIKit.h>

// 倒计时开始前的操作
typedef BOOL(^BeforeCountDown)();
// 倒计时进行时的操作
typedef void(^CountDown)();
// 倒计时结束后的操作
typedef void(^AfterCountDownFinish)();

@interface DTTCountdownButton : UIButton

// 倒计时进行时，秒数前的文字
@property (nonatomic, copy) NSString *prefixCountTitle;
// 倒计时进行时，秒数后的文字
@property (nonatomic, copy) NSString *suffixCountTitle;

// 按钮不可用时的背景色
@property (nonatomic, strong) UIColor *disableStateBackgroundColor;

// 倒计时开始前的操作
@property (nonatomic, assign) BeforeCountDown beforeCountDown;
// 倒计时进行时的操作
@property (nonatomic, assign) CountDown countDown;
// 倒计时结束后的操作
@property (nonatomic, assign) AfterCountDownFinish afterCountDownFinish;


- (instancetype)initWithSeconds:(NSInteger)seconds frame:(CGRect)frame;

// 手动开始倒计时（无倒计时开始前的操作）
- (void)manualStartCountDown;

// 手动停止倒计时
- (void)manualStopCountDown;


@end
