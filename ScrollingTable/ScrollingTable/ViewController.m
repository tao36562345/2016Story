//
//  ViewController.m
//  ScrollingTable
//
//  Created by badman on 16/2/12.
//  Copyright © 2016年 dengtao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UITableView *mTableView;
    NSMutableArray *rowData;
    
    UIButton *topButton;
    UIButton *bottomButton;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, screenWidth, screenHeight-50)
                                              style:UITableViewStylePlain];
    mTableView.delegate = self;
    mTableView.dataSource = self;
    [self.view addSubview:mTableView];
    
    topButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 100, 30)];
    [topButton setTitle:@"TOP"
               forState:UIControlStateNormal];
    [topButton setTitleColor:[UIColor blueColor]
                    forState:UIControlStateNormal];
    [topButton addTarget:self
                  action:@selector(scrollToTop:)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topButton];
    
    bottomButton = [[UIButton alloc] initWithFrame:CGRectMake(220, 20, 100, 30)];
    [bottomButton setTitle:@"BOTTOM" forState:UIControlStateNormal];
    [bottomButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [bottomButton addTarget:self
                     action:@selector(scrollToBottom:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomButton];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData
{
    if (rowData != nil) {
        [rowData removeAllObjects];
        rowData = nil;
    }
    
    rowData = [[NSMutableArray alloc] init];
    for (int i=0; i < 100; i++) {
        [rowData addObject:[NSString stringWithFormat:@"Row: %i", i]];
    }
    
    // now my datasource if populated let's reload the tableview
    [mTableView reloadData];
}

#pragma mark UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [rowData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [rowData objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark 自定义响应方法
- (void)scrollToTop:(UIButton *)sender
{
    NSIndexPath *topRow = [NSIndexPath indexPathForRow:0 inSection:0];
    [mTableView scrollToRowAtIndexPath:topRow
                      atScrollPosition:UITableViewScrollPositionTop
                              animated:YES];
}

- (void)scrollToBottom:(UIButton *)sender
{
    NSIndexPath *bottomRow = [NSIndexPath indexPathForRow:[rowData count]-1
                                                inSection:0];
    [mTableView scrollToRowAtIndexPath:bottomRow
                      atScrollPosition:UITableViewScrollPositionBottom
                              animated:YES];
}
@end
