//
//  URLRequest.m
//  WebsiteUsingBlocks
//
//  Created by dengtao on 16/3/30.
//  Copyright © 2016年 shengzhong. All rights reserved.
//

#import "URLRequest.h"

@interface URLRequest()<NSURLConnectionDataDelegate, NSURLConnectionDelegate>
{
    NSURLRequest *request;
    NSURLConnection *connection;
    NSMutableData *webData;
    int httpStatusCode;
    void (^completion)(URLRequest *request, NSData *data, BOOL success);
}

@end

@implementation URLRequest

- (id)initWithRequest:(NSURLRequest *)req
{
    self = [super init];
    if (self != nil)
    {
        request = req;
    }
    return self;
}

- (void)startWithCompletion:(void (^)(URLRequest *request, NSData *data, BOOL success))comple
{
    completion = [comple copy];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (connection)
    {
        webData = [[NSMutableData alloc] init];
    } else
    {
        completion(self, nil, NO);
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    completion(self, webData, httpStatusCode == 200);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    httpStatusCode = (int)[httpResponse statusCode];
    [webData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    completion(self, webData, NO);
}

@end
