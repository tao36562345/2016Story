//
//  ViewController.m
//  CompleteAudioPlayer
//
//  Created by dengtao on 16/3/23.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<AVAudioPlayerDelegate>
{
    UILabel *trackStatus;
    UISlider *trackSlider;
    UISlider *volumeSlider;
    UIButton *playButton;
    AVAudioPlayer *player;
    NSTimer *updateTimer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    trackStatus = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth/2-50, 40, 100, 40)];
    trackStatus.text = @"0:00";
    trackStatus.textColor = [UIColor blackColor];
    trackStatus.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:trackStatus];
    
    trackSlider = [[UISlider alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(trackStatus.frame)+20, screenWidth-40, 20)];
    [trackSlider addTarget:self action:@selector(trackSliderMoved:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:trackSlider];
    
    volumeSlider = [[UISlider alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(trackSlider.frame)+20, screenWidth-40, 20)];
    [volumeSlider addTarget:self action:@selector(volumeSliderMoved:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:volumeSlider];
    
    playButton = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth/2-50, CGRectGetMaxY(volumeSlider.frame)+40, 100, 40)];
    [playButton setTitle:@"播放" forState:UIControlStateNormal];
    [playButton addTarget:self action:@selector(playOrPause:) forControlEvents:UIControlEventTouchUpInside];
    [playButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    [self.view addSubview:playButton];
    
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Joan Jett & the Blackhearts - I Hate Myself For Loving You"
                                                                                        ofType:@"mp3"]];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    if (player) {
        [self updateViewForPlayerInfo:player];
        [self updateViewForPlayerState:player];
        [player prepareToPlay];
        player.delegate = self;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)playOrPause:(UIBarButtonItem *)sender
{
    if (player)
    {
        if (player.playing)
        {
            [player pause];
            
            [playButton setTitle:@"播放" forState:UIControlStateNormal];
            [self updateViewForPlayerState:player];
        } else
        {
            [player play];
            
            [playButton setTitle:@"暂停" forState:UIControlStateNormal];
            [self updateViewForPlayerState:player];
        }
    }
}

- (void)volumeSliderMoved:(UISlider *)sender
{
    player.volume = [sender value];
}

- (void)trackSliderMoved:(UISlider *)sender
{
    player.currentTime = sender.value;
    [self updateCurrentTimeForPlayer:player];
}

- (void)updateViewForPlayerInfo:(AVAudioPlayer *)p
{
    trackStatus.text = [NSString stringWithFormat:@"%d:%02d", (int)p.duration / 60, (int)p.duration % 60, nil];
    trackSlider.maximumValue = p.duration;
    volumeSlider.value = p.volume;
}

- (void)updateViewForPlayerState:(AVAudioPlayer *)p
{
    [self updateCurrentTimeForPlayer:p];
    if (updateTimer != nil) {
        [updateTimer invalidate];
    }
    
    if (p.playing) {
        [playButton setTitle:@"暂停" forState:UIControlStateNormal];
        updateTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateCurrentTime) userInfo:p repeats:YES];
    } else {
        [playButton setTitle:@"播放" forState:UIControlStateNormal];
        updateTimer = nil;
    }
    
}

- (void)updateCurrentTimeForPlayer:(AVAudioPlayer *)p
{
    trackStatus.text = [NSString stringWithFormat:@"%d:%02d", (int)p.currentTime / 60, (int)p.currentTime % 60, nil];
    trackSlider.value = p.currentTime;
}

- (void)updateCurrentTime
{
    [self updateCurrentTimeForPlayer:player];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [updateTimer invalidate];
    updateTimer = nil;
}

@end
