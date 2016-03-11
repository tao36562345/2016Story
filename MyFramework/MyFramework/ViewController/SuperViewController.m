//
//  SuperViewController.m
//  MyFramework
//
//  Created by dengtao on 16/3/9.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "SuperViewController.h"

@implementation SuperViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 解决iOS 7.0以上导航内容视图从(0，0)开始
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }

}

@end
