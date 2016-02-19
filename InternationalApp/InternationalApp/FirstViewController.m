//
//  FirstViewController.m
//  InternationalApp
//
//  Created by badman on 16/2/19.
//  Copyright © 2016年 dengtao. All rights reserved.
//

#import "FirstViewController.h"

@implementation FirstViewController

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first.png"];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 300, 40)];
    label.text = NSLocalizedString(@"First", @"First");
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
}

@end
