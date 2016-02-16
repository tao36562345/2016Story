//
//  ViewController.m
//  YDDrillDown
//
//  Created by badman on 16/2/15.
//  Copyright © 2016年 dengtao. All rights reserved.
//

#import "ViewController.h"
#import "YDCar.h"

#define HEADER_HEIGHT 60.0f

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, YDSectionHeaderViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CGRect appFrame = [[UIScreen mainScreen] bounds];
    
    // create the tableView
    self.mTableView = [[UITableView alloc] initWithFrame:appFrame style:UITableViewStylePlain];
    self.mTableView.dataSource = self;
    self.mTableView.delegate = self;
    self.mTableView.rowHeight = 60;
    self.mTableView.sectionHeaderHeight = HEADER_HEIGHT;
    [self.view addSubview:self.mTableView];
    [self loadData];
}

- (void)loadData
{
    // Create some models for Ford
    NSArray *ford = [[NSArray alloc] initWithObjects:
                     [[YDCar alloc] initWithMake:@"Ford"
                                           model:@"2013 F-150"
                                       imageName:@"2013f150.jpg"],
                     [[YDCar alloc] initWithMake:@"Ford"
                                           model:@"2013 Super Duty"
                                       imageName:@"2013superduty.jpg"],
                     [[YDCar alloc] initWithMake:@"Ford"
                                           model:@"Shelby GT500"
                                       imageName:@"shelbygt500.jpg"],
                     nil];
    
    // create some models for Chevrolet
    NSArray *chevy = [[NSArray alloc] initWithObjects:
                      [[YDCar alloc] initWithMake:@"Chevrolet"
                                            model:@"2013 Suburban 3/4 ton"
                                        imageName:@"suburban.png"],
                      [[YDCar alloc] initWithMake:@"Chevrolet"
                                            model:@"2012 Colorado"
                                        imageName:@"colorado.jpg"],
                      nil];
    
    // create a dictionary to store them
    self.dataDict = [[NSMutableDictionary alloc] init];
    [self.dataDict setObject:ford forKey:@"Ford"];
    [self.dataDict setObject:chevy forKey:@"Chevrolet"];
    
    // Create an array of YDSectionHeaderViews with the title and number of rows
    self.arrayOfSectionHeaders = [[NSMutableArray alloc] init];
    int sectionNr = 0;
    for (id key in self.dataDict)
    {
        id anObject = [self.dataDict objectForKey:key];
        YDSectionHeaderView *make = [[YDSectionHeaderView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320, HEADER_HEIGHT)
                                                                         title:key
                                                                       section:sectionNr
                                                                      delegate:self
                                                                        numrow:[anObject count]];
        [self.arrayOfSectionHeaders addObject:make];
        sectionNr++;
    }
    
    self.openSectionIndex = NSNotFound;
    [self.mTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma HEADER
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    YDSectionHeaderView *sectionHeaderView = (YDSectionHeaderView *)[self.arrayOfSectionHeaders objectAtIndex:section];
    return sectionHeaderView;
}

- (void)sectionHeaderView:(YDSectionHeaderView *)sectionHeaderView sectionOpened:(NSInteger)section
{
    if (section != NSNotFound)
    {
        // all sections are closed so we can't do anything
        YDSectionHeaderView *sectionHeaderView = [self.arrayOfSectionHeaders objectAtIndex:section];
        sectionHeaderView.expanded = YES;
        
        /*
         Create an array containing the index paths of the rows to insert
         These correspond to the rows for each quotation in the
         current section.
         */
        NSInteger countOfRowsToInsert = sectionHeaderView.numberOfRows;
        NSMutableArray *indexPathsToInset = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < countOfRowsToInsert; i++)
        {
            [indexPathsToInset addObject:[NSIndexPath indexPathForItem:i inSection:section]];
        }
        
        /*
         Create an array containing the index paths of the rows to delete:
         These correspond to the rows for each quotation in the
         previously-open section, if there was one.
         */
        NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
        NSInteger previousOpenSectionIndex = self.openSectionIndex;
        if (previousOpenSectionIndex != NSNotFound)
        {
            YDSectionHeaderView *previousOpenSectionHeaderView = [self.arrayOfSectionHeaders objectAtIndex:previousOpenSectionIndex];
            previousOpenSectionHeaderView.expanded = NO;
            [previousOpenSectionHeaderView toggleOpenWithUserAction:NO];
            NSInteger countOfRowToDelete = previousOpenSectionHeaderView.numberOfRows;
            
            for (NSInteger i = 0; i < countOfRowToDelete; i++)
            {
                [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:previousOpenSectionIndex]];
            }
        }
        
        // Style the animation so that there's a smooth flow in either direction.
        UITableViewRowAnimation insertAnimation;
        UITableViewRowAnimation deleteAnimation;
        if (previousOpenSectionIndex == NSNotFound ||
            section < previousOpenSectionIndex)
        {
            insertAnimation = UITableViewRowAnimationTop;
            deleteAnimation = UITableViewRowAnimationBottom;
        } else
        {
            insertAnimation = UITableViewRowAnimationBottom;
            deleteAnimation = UITableViewRowAnimationTop;
        }
        
        // Apply the updates.
        [self.mTableView beginUpdates];
        [self.mTableView insertRowsAtIndexPaths:indexPathsToInset
                               withRowAnimation:insertAnimation];
        [self.mTableView deleteRowsAtIndexPaths:indexPathsToDelete
                               withRowAnimation:deleteAnimation];
        [self.mTableView endUpdates];
        self.openSectionIndex = section;
    }
}

- (void)sectionHeaderView:(YDSectionHeaderView *)sectionHeaderView sectionClosed:(NSInteger)section
{
    YDSectionHeaderView *thisSectionHeaderView = [_arrayOfSectionHeaders objectAtIndex:section];
    thisSectionHeaderView.expanded = NO;
    
    NSInteger countOfRowsToDelete = [self.mTableView numberOfRowsInSection:section];
    if (countOfRowsToDelete > 0)
    {
        NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < countOfRowsToDelete; i++)
        {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:section]];
        }
        [self.mTableView deleteRowsAtIndexPaths:indexPathsToDelete
                               withRowAnimation:UITableViewRowAnimationTop];
    }
    self.openSectionIndex = NSNotFound;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.arrayOfSectionHeaders objectAtIndex:section];
}

#pragma UITableView delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.arrayOfSectionHeaders count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    YDSectionHeaderView *sectionHeaderView = [_arrayOfSectionHeaders objectAtIndex:section];
    NSInteger numStoriesInSection = sectionHeaderView.numberOfRows;
    return sectionHeaderView.expanded ? numStoriesInSection : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    YDSectionHeaderView *shv = (YDSectionHeaderView *)[self.arrayOfSectionHeaders objectAtIndex:indexPath.section];
    YDCar *car = (YDCar *)[[self.dataDict objectForKey:shv.key] objectAtIndex:indexPath.row];
    UILabel *carlbl = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 250, 60)];
    carlbl.textColor = [UIColor blueColor];
    carlbl.backgroundColor = [UIColor whiteColor];
    carlbl.text = [NSString stringWithFormat:@"%@ %@", car.make, car.model];
    [cell.contentView addSubview:carlbl];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    imgView.backgroundColor = [UIColor clearColor];
    [imgView setImage:[UIImage imageNamed:car.imageName]];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [cell.contentView addSubview:imgView];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
