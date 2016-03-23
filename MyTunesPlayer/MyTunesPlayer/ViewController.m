//
//  ViewController.m
//  MyTunesPlayer
//
//  Created by badman on 16/3/24.
//  Copyright © 2016年 dengtao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view, typically from a nib.
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, screenWidth, screenHeight-50)
                                                 style:UITableViewStylePlain];
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    [self.view addSubview:self.mainTableView];
    
    self.musicPlayer = [MPMusicPlayerController applicationMusicPlayer];
    [self loadMedia];
}

- (void)loadMedia
{
    // query all songs
    MPMediaQuery *allSongsQuery = [MPMediaQuery songsQuery];
    self.allItems = [[NSMutableArray alloc] initWithArray:[allSongsQuery collections]];
    [self.mainTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.allItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MyCellIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCellIdentifier"];
    }
    MPMediaItem *item = [[self.allItems objectAtIndex:indexPath.row] representativeItem];
    MPMediaItemArtwork *artwork = [item valueForProperty:MPMediaItemPropertyArtwork];
    
    if (artwork) {
        cell.imageView.image = [artwork imageWithSize:CGSizeMake(30, 30)];
    }
    cell.textLabel.text = [item valueForProperty:MPMediaItemPropertyAlbumTitle];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.musicPlayer stop];
    [self.musicPlayer setQueueWithItemCollection:NULL];
    
    MPMediaItem *item = [[self.allItems objectAtIndex:indexPath.row] representativeItem];
    MPMediaPropertyPredicate *myPredicate = [MPMediaPropertyPredicate predicateWithValue:[item valueForProperty:MPMediaItemPropertyAlbumPersistentID]
                                                                             forProperty:MPMediaItemPropertyAlbumPersistentID
                                                                          comparisonType:MPMediaPredicateComparisonContains];
    MPMediaQuery *songsQuery = [MPMediaQuery songsQuery];
    [songsQuery addFilterPredicate:myPredicate];
    
    // set Query direct to Queue
    [self.musicPlayer setQueueWithQuery:songsQuery];
    [self.musicPlayer prepareToPlay];
    [self.musicPlayer play];
}

@end
