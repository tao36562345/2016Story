//
//  ViewController.m
//  AudioRecorder
//
//  Created by dengtao on 16/3/24.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<AVAudioRecorderDelegate, AVAudioPlayerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.playButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 40)];
    [self.playButton setTitle:@"播放" forState:UIControlStateNormal];
    [self.playButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.playButton setHidden:YES];
    [self.playButton addTarget:self action:@selector(startPlaying:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.playButton];
    
    self.recordButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, 100, 40)];
    [self.recordButton setTitle:@"开始录音" forState:UIControlStateNormal];
    [self.recordButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.recordButton addTarget:self action:@selector(startRecording:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.recordButton];
    
    self.stopButton = [[UIButton alloc] initWithFrame:self.playButton.frame];
    [self.stopButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.stopButton setTitle:@"停止" forState:UIControlStateNormal];
    [self.stopButton setHidden:YES];
    [self.stopButton addTarget:self action:@selector(stopRecording:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.stopButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSURL *)soundFileURL
{
    NSArray *dirPaths;
    NSString *docsDir;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    NSString *soundFilePath = [docsDir stringByAppendingPathComponent:@"recording.m4a"];
    return [NSURL fileURLWithPath:soundFilePath];
}

- (void)startRecording:(UIButton *)sender
{
    [self.recordButton setHidden:YES];
    [self.stopButton setHidden:NO];
    [self.playButton setHidden:YES];
    
    // create a dictionary for the recording settings
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    [recordSetting setValue:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
    [recordSetting setValue:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    
    NSError *error = nil;
    self.audioRecorder = [[AVAudioRecorder alloc] initWithURL:[self soundFileURL]
                                                     settings:recordSetting
                                                        error:&error];
    
    self.audioRecorder.delegate = self;
    if (error)
    {
        NSLog(@"error: %@", [error localizedDescription]);
    } else
    {
        [self.audioRecorder prepareToRecord];
    }
    
    if (!self.audioRecorder.recording)
    {
        self.recordButton.enabled = NO;
        self.stopButton.enabled = YES;
        [self.audioRecorder record];
    }
}

- (void)startPlaying:(UIButton *)sender
{
    [self.playButton setUserInteractionEnabled:NO];
    NSURL *url = [self soundFileURL];
    NSError *error = nil;
    
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                              error:&error];
    
    if (error)
    {
        NSLog(@"Error in audioPlayer: %@", [error localizedDescription]);
    } else
    {
        self.audioPlayer.delegate = self;
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
    }
}

- (void)stopRecording:(UIButton *)sender
{
    [self.stopButton setHidden:YES];
    [self.recordButton setHidden:NO];
    self.recordButton.enabled = YES;
    self.stopButton.enabled = NO;
    [self.audioRecorder stop];
    self.audioRecorder = nil;
    [self.playButton setHidden:NO];
}

#pragma mark - delegates
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    self.audioPlayer = nil;
    [self.playButton setUserInteractionEnabled:YES];
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thanks"
                                                    message:@"Your recording has finished"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:@"An error has occured"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
}
@end
