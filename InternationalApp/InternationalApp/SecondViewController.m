//
//  SecondViewController.m
//  InternationalApp
//
//  Created by badman on 16/2/19.
//  Copyright © 2016年 dengtao. All rights reserved.
//

#import "SecondViewController.h"

@implementation SecondViewController

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.title = NSLocalizedString(@"Second", @"Second");
        self.tabBarItem.image = [UIImage imageNamed:@"second.png"];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 300, 40)];
    label.text = NSLocalizedString(@"Second", @"Second");
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}
@end
