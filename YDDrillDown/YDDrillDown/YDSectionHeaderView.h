//
//  YDSectionHeaderView.h
//  YDDrillDown
//
//  Created by badman on 16/2/15.
//  Copyright © 2016年 dengtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YDSectionHeaderViewDelegate;

@interface YDSectionHeaderView : UIView

@property (nonatomic, assign) BOOL expanded;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIButton *disclosureButton;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) NSInteger numberOfRows;
@property (nonatomic, retain) NSString *key;
@property (nonatomic, assign) id<YDSectionHeaderViewDelegate> delegate;

// initializer
- (id)initWithFrame:(CGRect)frame title:(NSString *)title section:(NSInteger)sectionNumber delegate:(id<YDSectionHeaderViewDelegate>)delegate numrow:(NSInteger)numOfRows;

- (void)toggleOpenWithUserAction:(BOOL)userAction;

@end

@protocol YDSectionHeaderViewDelegate <NSObject>

@optional
- (void)sectionHeaderView:(YDSectionHeaderView *)sectionHeaderView sectionOpened:(NSInteger)section;
- (void)sectionHeaderView:(YDSectionHeaderView *)sectionHeaderView sectionClosed:(NSInteger)section;

@end
