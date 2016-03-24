//
//  ViewController.h
//  AudioRecorder
//
//  Created by dengtao on 16/3/24.
//  Copyright © 2016年 dt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) UIButton *stopButton;
@property (nonatomic, strong) UIButton *recordButton;

@property (nonatomic, strong) AVAudioRecorder *audioRecorder;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end

