//
//  ViewController.m
//  SimpleHTTPCall
//
//  Created by badman on 16/3/27.
//  Copyright © 2016年 dengtao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLConnectionDelegate, NSURLConnectionDataDelegate>
{
    NSURLConnection *connection;
    NSMutableData *webData;
}

@property (nonatomic, strong) UITextView *responseView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen  mainScreen].bounds.size.height;
    
    UIButton *downloadButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, screenWidth, 100)];
    [downloadButton setTitle:@"Download HTML" forState:UIControlStateNormal];
    [downloadButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [downloadButton setBackgroundColor:[UIColor grayColor]];
    [downloadButton addTarget:self action:@selector(downloadHTML:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:downloadButton];
    
    self.responseView = [[UITextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(downloadButton.frame), screenWidth, screenHeight - 120)];
    [self.view addSubview:self.responseView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)downloadHTML:(UIButton *)sender
{
    self.responseView.text = @"";
    
    // Create a NSURL object with string using the HTTP protocol
    NSURL *url = [NSURL URLWithString:@"http://www.apple.com"];
    // Create a NSURLRequest from the URL
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    // it's not required to set the HTTP method since
    // if not set it will default to GET
    [theRequest setHTTPMethod:@"GET"];
    connection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (connection)
    {
        webData = [[NSMutableData alloc] init];
    }
}

#pragma mark - NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:@"Can't make a connection"
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark - NSURLConnectionDataDelegate 

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *responseString = [[NSString alloc] initWithBytes:[webData mutableBytes]
                                                        length:[webData length]
                                                      encoding:NSUTF8StringEncoding];
    self.responseView.text = responseString;
}
@end
