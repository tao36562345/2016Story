//
//  ViewController.h
//  MyTunesPlayer
//
//  Created by badman on 16/3/24.
//  Copyright © 2016年 dengtao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *allItems;
@property (nonatomic, strong) MPMusicPlayerController *musicPlayer;

@end