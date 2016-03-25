//
//  ViewController.m
//  AudioRecorder
//
//  Created by dengtao on 16/3/24.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<AVAudioRecorderDelegate, AVAudioPlayerDelegate>

@property (nonatomic, strong) UIImageView *soundLodingImageView;
@property (nonatomic, strong) UIButton *playButton;

// 录音器
@property (nonatomic, strong) AVAudioRecorder *recorder;
// 播放器
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, copy) NSDictionary *recorderSettingDict;

// 定时器
@property (nonatomic, strong) NSTimer *timer;
// 图片组
@property (nonatomic, strong) NSMutableArray *volumImages;
@property (nonatomic, assign) double lowPassResults;

// 录音名字
@property (nonatomic, copy) NSString *playName;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    // 加载界面
    [self loadSubviews];
    
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    {
        // 7.0第一次运行提示，是否允许使用麦克风
        AVAudioSession *session = [AVAudioSession sharedInstance];
        NSError *sessionError;
        
        // AVAudioSessionCategoryPlayAndRecord用于录音和播放
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
        if (session == nil)
        {
            NSLog(@"Error creating session: %@", [sessionError description]);
        } else
        {
            [session setActive:YES error:nil];
        }
    }
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    self.playName = [NSString stringWithFormat:@"%@/play.aac", docDir];
    
    // 录音设置
    self.recorderSettingDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                    [NSNumber numberWithInt:kAudioFormatMPEG4AAC], AVFormatIDKey,
                    [NSNumber numberWithInt:1000.0], AVSampleRateKey,
                    [NSNumber numberWithInt:2], AVNumberOfChannelsKey,
                    [NSNumber numberWithInt:8], AVLinearPCMBitDepthKey,
                    [NSNumber numberWithBool:NO], AVLinearPCMIsBigEndianKey,
                    [NSNumber numberWithBool:NO], AVLinearPCMIsFloatKey,
                    nil];
    // 音量图片数组
    self.volumImages = [[NSMutableArray alloc] initWithObjects:@"RecordingSignal001",@"RecordingSignal002",@"RecordingSignal003",
                        @"RecordingSignal004", @"RecordingSignal005",@"RecordingSignal006",
                        @"RecordingSignal007",@"RecordingSignal008", nil];
}

- (void)loadSubviews
{
    UIView *iconView = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
    iconView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:iconView];
    
    UIImageView *phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 50, 36, 99)];
    phoneImageView.image = [UIImage imageNamed:@"RecordingBkg"];
    [iconView addSubview:phoneImageView];
    
    self.soundLodingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(140, 120, 30, 50)];
    [iconView addSubview:self.soundLodingImageView];
    
    
    self.playButton = [[UIButton alloc] initWithFrame:CGRectMake(300, CGRectGetMaxY(iconView.frame)+100, 50, 30)];
    [self.playButton setTitle:@"播放" forState:UIControlStateNormal];
    [self.playButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.playButton addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.playButton];
    
    UIButton *recordButton = [[UIButton alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(iconView.frame)+100, 100, 30)];
    [recordButton setTitle:@"按住说话" forState:UIControlStateNormal];
    [recordButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [recordButton setTitle:@"松开" forState:UIControlStateHighlighted];
    [recordButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [recordButton addTarget:self action:@selector(downAction:) forControlEvents:UIControlEventTouchDown];
    [recordButton addTarget:self action:@selector(upAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:recordButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)downAction:(UIButton *)sender
{
    // 按下录音
    if ([self canRecord])
    {
        NSError *error = nil;
        // 必须真机上测试，模拟器上可能会崩溃
        self.recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL URLWithString:self.playName] settings:self.recorderSettingDict error:&error];
        
        if (self.recorder)
        {
            self.recorder.meteringEnabled = YES;
            [self.recorder prepareToRecord];
            [self.recorder record];
        
            // 启动定时器
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(levelTimer:) userInfo:nil repeats:YES];
        } else
        {
            int errorCode = CFSwapInt32HostToBig([error code]);
            NSLog(@"Error: %@ [%4.4s]", [error localizedDescription], (char*)&errorCode);
        }
    }
}

- (void)upAction:(UIButton *)sender
{
    // 松开 结束录音
    
    // 录音停止
    [self.recorder stop];
    self.recorder = nil;
    // 结束定时器
    [self.timer invalidate];
    self.timer = nil;
    // 图片重置
    self.soundLodingImageView.image = [UIImage imageNamed:[self.volumImages objectAtIndex:0]];
}

- (void)playAction:(UIButton *)sender
{
    NSError *playerError;
    
    // 播放
    self.player = nil;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:self.playName] error:&playerError];
    
    if (self.player == nil)
    {
        NSLog(@"Error creating player: %@", [playerError description]);
    } else
    {
        [self.player play];
    }
}

- (void)levelTimer:(NSTimer *)timer_
{
    // call to refresh meter values刷新平均和峰值功率，此技术是以对数刻度计量的，-160表示完全安静，0表示最大输入值
    [self.recorder updateMeters];
    const double ALPHA = 0.05;
    double peakPowerForChannel = pow(10, (0.05 * [self.recorder peakPowerForChannel:0]));
    self.lowPassResults = ALPHA * peakPowerForChannel + (1.0 - ALPHA) * self.lowPassResults;
    
    NSLog(@"Average input: %f Peak input: %f Low pass results: %f", [self.recorder averagePowerForChannel:0], [self.recorder peakPowerForChannel:0], self.lowPassResults);
    
    if (self.lowPassResults >= 0.8)
    {
        self.soundLodingImageView.image = [UIImage imageNamed:[self.volumImages objectAtIndex:7]];
    } else if (self.lowPassResults >= 0.7) {
        self.soundLodingImageView.image = [UIImage imageNamed:[self.volumImages objectAtIndex:6]];
    } else if (self.lowPassResults >= 0.6) {
        self.soundLodingImageView.image = [UIImage imageNamed:[self.volumImages objectAtIndex:5]];
    } else if (self.lowPassResults >= 0.5) {
        self.soundLodingImageView.image = [UIImage imageNamed:[self.volumImages objectAtIndex:4]];
    } else if (self.lowPassResults >= 0.4) {
        self.soundLodingImageView.image = [UIImage imageNamed:[self.volumImages objectAtIndex:3]];
    } else if (self.lowPassResults >= 0.3) {
        self.soundLodingImageView.image = [UIImage imageNamed:[self.volumImages objectAtIndex:2]];
    } else if (self.lowPassResults >= 0.2) {
        self.soundLodingImageView.image = [UIImage imageNamed:[self.volumImages objectAtIndex:1]];
    } else if (self.lowPassResults >= 0.1) {
        self.soundLodingImageView.image = [UIImage imageNamed:[self.volumImages objectAtIndex:0]];
    } else {
        self.soundLodingImageView.image = [UIImage imageNamed:[self.volumImages objectAtIndex:0]];
    }
}

// 判断是否允许使用麦克风7.0新增的方法requestRecordPermission
- (BOOL)canRecord
{
    __block BOOL bCanRecord = YES;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:)
                               withObject:^(BOOL granted){
                                   if (granted) {
                                       bCanRecord = YES;
                                   } else {
                                       bCanRecord = NO;
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           [[[UIAlertView alloc] initWithTitle:nil
                                                                      message:@"app需要访问您的麦克风。\n请启用麦克风-设置/隐私/麦克风"
                                                                     delegate:nil
                                                             cancelButtonTitle:@"关闭" otherButtonTitles: nil] show];
                                       });
                                   }
                               }];
        }
    }
    
    return bCanRecord;
}
@end
