//
//  ViewController.m
//  FotoDownloader
//
//  Created by badman on 16/3/28.
//  Copyright © 2016年 dengtao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLConnectionDataDelegate,NSURLConnectionDelegate,NSURLConnectionDownloadDelegate>
{
    NSInteger fileSize;
    NSInteger bytesDownloaded;
}

@property (nonatomic, strong) UILabel *statusLabe;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UIImageView *receivedImage;

@property (nonatomic, strong) NSOutputStream *fileStream;
@property (nonatomic, assign) BOOL isReceiving;
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, copy) NSString *filePath;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    UIButton *downButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 50, screenWidth-40, 50)];
    [downButton setTitle:@"Start Download" forState:UIControlStateNormal];
    [downButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [downButton addTarget:self action:@selector(downloadImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:downButton];
    
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(downButton.frame)+20, screenWidth-40, 10)];
    [self.view addSubview:self.progressView];
    
    self.statusLabe = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.progressView.frame)+20, screenWidth, 30)];
    self.statusLabe.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.statusLabe];
    
    self.receivedImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(downButton.frame)+100, screenWidth, 200)];
    self.receivedImage .backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.receivedImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)downloadImage:(UIButton *)sender
{
    BOOL success;
    NSURL *url;
    NSURLRequest *request;
    
    url = [NSURL URLWithString:@"http://n.sinaimg.cn/news/20160328/UD-s-fxqswxn6456032.jpg"];
    success = (url != nil);
    
    // Open a stream for the file we're going to receive into.
    self.filePath = [self createFileName];
    // create the output stream
    self.fileStream = [NSOutputStream outputStreamToFileAtPath:self.filePath append:NO];
    // open the stream
    [self.fileStream open];
    
    // create the request
    request = [NSURLRequest requestWithURL:url];
    
    // create the connection with the request
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    // clear the image
    self.receivedImage.image = nil;
    self.progressView.progress = 0;
}

- (NSString *)createFileName
{
    // Create a file name based on timestamp
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"ddmmyyyy-HHmmssSSS"];
    return [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", [formatter stringFromDate:[NSDate date]]]];
}

- (void)stopReceiveWithStatus:(NSString *)statusString
// Shuts down the connection and displays the result
{
    if (self.connection != nil)
    {
        [self.connection cancel];
        self.connection = nil;
    }
    if (self.fileStream != nil)
    {
        [self.fileStream close];
        self.fileStream = nil;
    }
    self.statusLabe.text = statusString;
    self.receivedImage.image = [UIImage imageWithContentsOfFile:self.filePath];
    self.filePath = nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // create a static NSSet with mime types your download will support
    static NSSet *sSupportedImageTypes;
    NSHTTPURLResponse *httpResponse;
    if (sSupportedImageTypes == nil)
    {
        sSupportedImageTypes = [[NSSet alloc] initWithObjects:@"image/jpeg", @"image/png", @"image/gif", nil];
    }
    httpResponse = (NSHTTPURLResponse *)response;
    
    // read the content length from the header field
    fileSize = [[[httpResponse allHeaderFields] valueForKey:@"Content-Length"] integerValue];
    bytesDownloaded = 0;
    
    // check the status code
    if (httpResponse.statusCode != 200)
    {
        NSLog(@"error:%@", [NSString stringWithFormat:@"HTTP error %zd", (ssize_t)httpResponse.statusCode]);
    } else
    {
        NSString *fileMIMEType;
        fileMIMEType = [[httpResponse MIMEType] lowercaseString];
        
        if (fileMIMEType == nil)
        {
            [self stopReceiveWithStatus:@"No Content-Type"];
        } else if (![sSupportedImageTypes containsObject:fileMIMEType])
        {
            [self stopReceiveWithStatus:[NSString stringWithFormat:@"Unsupported Content-Type (%@)", fileMIMEType]];
        } else
        {
            self.statusLabe.text = @"Response OK";
        }
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
// delegate called by the NSURLConnection as data arrives.
// just write the data to the file.
{
    // you need some variable to keep track on where you are writing bytes
    // coming in over the data stream
    NSInteger dataLength;
    const uint8_t *dataBytes;
    NSInteger bytesWritten;
    NSInteger bytesWrittenSoFar;
    dataLength = [data length];
    dataBytes = [data bytes];
    bytesWrittenSoFar = 0;
    
    do {
        bytesWritten = [self.fileStream write:&dataBytes[bytesWrittenSoFar] maxLength:dataLength - bytesWrittenSoFar];
        
        if (bytesWritten == -1) {
            [self stopReceiveWithStatus:@"File write error"];
            break;
        } else
        {
            bytesWrittenSoFar += bytesWritten;
        }
        bytesDownloaded += bytesWritten;
        self.progressView.progress = ((float)bytesDownloaded / (float)fileSize);
    } while (bytesWrittenSoFar != dataLength);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self stopReceiveWithStatus:@"Connection Failed"];
}

- (void)connectionDidFinishDownloading:(NSURLConnection *)connection destinationURL:(NSURL *)destinationURL
{
    [self stopReceiveWithStatus:@"download has finished"];
}
@end
