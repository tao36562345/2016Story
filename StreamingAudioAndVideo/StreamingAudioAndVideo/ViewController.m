//
//  ViewController.m
//  StreamingAudioAndVideo
//
//  Created by dengtao on 16/3/24.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *playButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 40)];
    [playButton setTitle:@"Play Audio Stream" forState:UIControlStateNormal];
    [playButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [playButton addTarget:self action:@selector(playStream:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playButton];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)playStream:(UIButton *)sender
{
    NSURL *streamURL = [NSURL URLWithString:@"http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8"];
    self.moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:streamURL];
    [self.moviePlayerController prepareToPlay];
    [self.moviePlayerController play];
}
@end
