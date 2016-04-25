//
//  StateView.m
//  GoodPeople
//
//  Created by yujiuyin on 15/9/6.
//  Copyright (c) 2015年 yujiuyin. All rights reserved.
//

#import "StateBarView.h"
#import "AppDelegate.h"





@implementation StateBarView

+ (StateBarView *)sharedInstance
{
    static StateBarView *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        [sharedInstance setBackgroundColor:CLEAR_COLOR];
    });
    
    return sharedInstance;
}

- (void)showStateBarView:(NSString *)showStr{
    theApp.window.windowLevel = 1500;//UIWindowLevelAlert;
    [self setFrame:[UIApplication sharedApplication].statusBarFrame];
    [theApp.window addSubview:self];
    
    if (!contentLab) {
        contentLab = [[UILabel alloc] init];
        [contentLab setBackgroundColor:CLEAR_COLOR];
        [contentLab setTextAlignment:NSTextAlignmentCenter];
        [contentLab setTextColor:WHITE_COLOR];
        [contentLab setFont:Font(14)];
    }
    [contentLab setFrame:CGRectMake(0, -20, SCREEN_WIDTH, 20)];
    
    if (![self.subviews containsObject:contentLab]) {
        [self addSubview:contentLab];
    }
    [contentLab setText:showStr];

    CGRect rc = [UIApplication sharedApplication].statusBarFrame;
    
    [UIView beginAnimations:@"animationName" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(guideHidden)];
    [contentLab setFrame:rc];
    [UIView commitAnimations];
}

- (void)guideHidden{
    [UIView beginAnimations:@"animationName" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeStateBarView)];
    [contentLab setFrame:CGRectMake(0, -20, SCREEN_WIDTH, 20)];
    [UIView commitAnimations];
}

- (void)removeStateBarView{
    if ([self.subviews containsObject:contentLab]) {
        [contentLab removeFromSuperview];
    }
    [self removeFromSuperview];
    theApp.window.windowLevel = UIWindowLevelNormal;

}

@end
