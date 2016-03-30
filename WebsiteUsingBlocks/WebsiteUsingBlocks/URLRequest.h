//
//  URLRequest.h
//  WebsiteUsingBlocks
//
//  Created by dengtao on 16/3/30.
//  Copyright © 2016年 shengzhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLRequest : NSObject

- (id)initWithRequest:(NSURLRequest *)req;
- (void)startWithCompletion:(void (^)(URLRequest *request, NSData *data, BOOL success))comple;

@end
