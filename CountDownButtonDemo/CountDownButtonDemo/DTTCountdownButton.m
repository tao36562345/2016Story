//
//  DTCountdownButton.m
//
//  Created by dengtao on 15/12/30.
//  Copyright © 2015年 dt. All rights reserved.
//

#import "DTTCountdownButton.h"

@interface DTTCountdownButton ()
{
    // 按钮正常时的背景色
    UIColor *originBackgroundColor;
    // 倒计时秒数
    NSInteger count;
    // 倒计时初始秒数
    NSInteger originCount;
    NSTimer *timer;
}

@end

@implementation DTTCountdownButton

- (instancetype)initWithSeconds:(NSInteger)seconds frame:(CGRect)frame
{
    self = [self initWithFrame:frame];
    if (self)
    {
        originCount = seconds;
        count = seconds;
        [self addTarget:self action:@selector(countdownStart:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark - 公共方法
// 手动开始倒计时（无倒计时开始前的操作）
- (void)manualStartCountDown
{
    // 开始倒计时后，修改按钮状态
    [self setDisableState];
    
    // 倒计时进行时的操作
    if (self.countDown) {
        self.countDown();
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
    // 使计时器立即触发
    [timer fire];
}

// 结束倒计时
- (void)manualStopCountDown {
    [self countdownFinish];
}

#pragma mark - 父类方法
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    NSAssert(controlEvents == UIControlEventTouchUpInside, @"请使用回调方法");
    [super addTarget:target action:action forControlEvents:controlEvents];
}

#pragma mark - 响应方法
- (void)countdownStart:(UIButton *)sender
{
    // 当倒计时开始前的处理存在且返回为YES，或者倒计时开始前不需要进行处理时，倒计时开始
    if (!self.beforeCountDown || (self.beforeCountDown && self.beforeCountDown()))
    {
        [self manualStartCountDown];
    }
}

#pragma mark - 计数相关方法
- (void)countdown
{
    if (count == -1)
    {
        // 计数结束
        [self countdownFinish];
        return;
    }
    
    // 更新按钮的title
    NSString *countdownTitle = [NSString stringWithFormat:@"%@%ld%@",
                                self.prefixCountTitle == nil ? @"" : self.prefixCountTitle,
                                count,
                                self.suffixCountTitle == nil ? @"" : self.suffixCountTitle];
    [self setTitle:countdownTitle forState:UIControlStateDisabled];
    count--;
}

- (void)countdownFinish
{
    // 倒计时结束后进行的操作
    if (self.afterCountDownFinish)
    {
        self.afterCountDownFinish();
    }
    
    // 重置按钮状态
    [self resetButton];
}

// 重置按钮
- (void)resetButton
{
    [self setEnabled:YES];
    // 重置倒计时秒数
    count = originCount;
    // 重置背景色
    [self setBackgroundColor:originBackgroundColor];
    
    if (timer == nil) {
        return;
    }
    
    [timer invalidate];
    timer = nil;
}

// 设置倒计时进行时的按钮状态
- (void)setDisableState
{
    // 保存原有背景色
    originBackgroundColor = self.backgroundColor;
    
    [self setEnabled:NO];
    if (self.disableStateBackgroundColor)
    {
        [self setBackgroundColor:[UIColor grayColor]];
    }
}
@end
