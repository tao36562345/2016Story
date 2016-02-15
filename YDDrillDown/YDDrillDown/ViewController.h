//
//  ViewController.h
//  YDDrillDown
//
//  Created by badman on 16/2/15.
//  Copyright © 2016年 dengtao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDSectionHeaderView.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) UITableView *mTableView;
@property (nonatomic, assign) NSInteger openSectionIndex;
@property (nonatomic, strong) NSMutableArray *arrayOfSectionHeaders;
@property (nonatomic, strong) NSMutableDictionary *dataDict;

@end

