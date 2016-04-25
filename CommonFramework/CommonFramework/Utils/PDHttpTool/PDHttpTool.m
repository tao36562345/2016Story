//
//  ZIHttpTool.m
//  HandleHttp
//
//  Created by zcd on 16/3/28.
//  Copyright © 2016年 zcd. All rights reserved.
//

#import "PDHttpTool.h"

#import "AFNetworking.h"

@implementation PDHttpTool
static PDHttpTool *_instance;

#pragma mark - 单例模式
+ (instancetype)sharedHttpTool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _instance = [[self alloc] initWithBaseURL:nil];
        
        _instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];
    });
    return _instance;
}

#pragma mark - alloc方法底层会调用，更加安全
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return _instance;
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    return _instance;
}

- (void)monitorNetworkStatus
{
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                NSLog(@"未知网络");
                self.networkStatus = NetworkStatusUnknown;
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                NSLog(@"没有网络(断网)");
                self.networkStatus = NetworkStatusNotReachable;
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                NSLog(@"手机自带网络");
                self.networkStatus = NetworkStatusReachableViaWWAN;
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                NSLog(@"WIFI");
                self.networkStatus = NetworkStatusReachableViaWiFi;
                break;
        }
    }];
    [mgr startMonitoring];
}

- (BOOL)isNetworkAvailable
{
    return [AFNetworkReachabilityManager sharedManager].isReachable;
}

#pragma mark - 发送请求方法
- (void)request:(PDHTTPMethod)method
      urlString:(NSString *)urlString
     parameters:(id)parameters
       finished:(PDFinished) finished {
    
    /// 成功回调block
    PDFinished success = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        finished(responseObject, nil);
    };
    /// 失败回调block
    PDFinished failure = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        finished(nil, error);
    };
    
    if (method == GET) {
        [self GET:urlString parameters:parameters progress:nil success:success failure:failure];
    } else if (method == POST) {
        [self POST:urlString parameters:parameters progress:nil success:success failure:failure];
    }
}

#pragma mark --GET请求--
- (void)GET:(NSString *)urlString parameters:(id)parameters finished:(PDFinished)finished{
    [self request:GET urlString:urlString parameters:parameters finished:finished];
}

#pragma mark --POST请求
- (void)POST:(NSString *)urlString
  parameters:(id)parameters
    finished:(PDFinished)finished{
    [self request:POST urlString:urlString parameters:parameters finished:finished];
}
@end
