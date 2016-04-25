//
//  PDHttpTool.h
//  HandleHttp
//
//  Created by zcd on 16/3/28.
//  Copyright © 2016年 zcd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

/// 网络请求方法枚举
typedef enum : NSUInteger{
    GET,
    POST
} PDHTTPMethod;

typedef NS_ENUM(NSInteger, NetworkStatus) {
    NetworkStatusUnknown          = -1,
    NetworkStatusNotReachable     = 0,
    NetworkStatusReachableViaWWAN = 1,
    NetworkStatusReachableViaWiFi = 2,
};

/// 定义回调block的别名
typedef void(^PDFinished)(id result, NSError *error);

@interface PDHttpTool : AFHTTPSessionManager

// 网络状态
@property (nonatomic, assign) NetworkStatus networkStatus;

/// 单例方法
+ (instancetype)sharedHttpTool;

/*
 * 开始监听网络
 */
- (void)monitorNetworkStatus;

/*
 * 网络是否可用
 * @return YES：网络连接正常 NO：断网
 */
- (BOOL)isNetworkAvailable;

/**
 *  封装AFN请求方法
 *
 *  @param method     请求类型
 *  @param urlString  请求的网络地址
 *  @param parameters 请求的参数
 *  @param finished   请求成功或者失败的回调
 */
- (void)request:(PDHTTPMethod)method
      urlString:(NSString *)urlString
     parameters:(id)parameters
       finished:(PDFinished) finished;

/**
 *  封装GET请求
 *
 *  @param urlString  请求的字符串
 *  @param parameters 请求的参数
 *  @param finished   请求成功或者失败的回调
 */
- (void) GET:(NSString *)urlString
  parameters:(id)parameters
    finished:(PDFinished)finished;

/**
 *  封装POST请求
 *
 *  @param urlString  请求的字符串
 *  @param parameters 请求的参数
 *  @param finished   请求成功或者失败的回调
 */
- (void) POST:(NSString *)urlString
   parameters:(id)parameters
     finished:(PDFinished)finished;

@end
