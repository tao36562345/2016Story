//
//  ViewController.h
//  PresidentSearch
//
//  Created by dengtao on 16/2/16.
//  Copyright © 2016年 dt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) UITableView *mTableView;
@property (nonatomic, strong) NSArray *presidents;
@property (nonatomic, strong) NSArray *filteredPresidents;
@property (nonatomic, retain) UISearchDisplayController *searchDisplayController;

@end

