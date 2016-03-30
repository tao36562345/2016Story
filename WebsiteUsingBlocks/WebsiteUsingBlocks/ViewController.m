//
//  ViewController.m
//  WebsiteUsingBlocks
//
//  Created by dengtao on 16/3/30.
//  Copyright © 2016年 shengzhong. All rights reserved.
//

#import "ViewController.h"
#import "URLRequest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 100)];
    imageView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:imageView];
    
    NSURL *myURL = [NSURL URLWithString:@"http://img.firefoxchina.cn/2016/03/4/201603301012320.jpg"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:myURL cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:60];
    
    URLRequest *urlRequest = [[URLRequest alloc] initWithRequest:request];
    [urlRequest startWithCompletion:^(URLRequest *request, NSData *data, BOOL success) {
        if (success) {
            imageView.image = [UIImage imageWithData:data];
        } else
        {
            NSLog(@"error %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
