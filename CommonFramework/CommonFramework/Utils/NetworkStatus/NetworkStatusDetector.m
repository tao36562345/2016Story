//
//  NetworkStatusDetector.m
//  SurfNewsHD
//
//  Created by yuleiming on 13-8-20.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "NetworkStatusDetector.h"

@implementation NetworkStatusDetector

+(NetworkStatusType) currentStatus
{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"]    subviews];
    NSNumber *dataNetworkItemView = nil;
    //UIStatusBarDataNetworkItemView
    NSString *str = [NSString stringWithFormat:@"%@StatusBar%@Network%@View", @"UI",@"Data",@"Item"];
    Class cls = [NSClassFromString(str) class];
    
    for (id subview in subviews)
    {
        if([subview isKindOfClass:cls])
        {
            dataNetworkItemView = subview;
            break;
        }
    }
    if(dataNetworkItemView)
        return [[dataNetworkItemView valueForKey:@"dataNetworkType"] intValue];
    else
        return NSTUnknown;
}

+ (BOOL)getNetWork{
    BOOL b = NO;
    NetworkStatusType type = [self currentStatus];
    if (type == NSTNoWifiOrCellular || type == NSTUnknown)
    {
//        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:nil message:@"当前没有网络连接!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        alt.tag = 43;
//        [alt show];
    }
    else if(type == NST2G || type == NST3G || type == NST4G || type == NSTLTE)
    {
//        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:nil message:@"您尚未连接WiFi,选择继续将消耗您的流量,确定继续?" delegate:self cancelButtonTitle:@"继续" otherButtonTitles:nil];
//        [alt show];
    }
    else if(type == NSTWifi)
    {
        b = YES;
    }
    return b;
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (1 == buttonIndex) {
        self.altBt(self);
    }
}


@end
