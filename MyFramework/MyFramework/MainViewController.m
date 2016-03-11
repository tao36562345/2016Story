//
//  MainViewController.m
//  MyFramework
//
//  Created by dengtao on 16/3/7.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "MainViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //if 使tabBarController中管理的viewControllers都符合 UIRectEdgeNone
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.title = @"第一个界面";
    
    [self loadSubviews];
}

#pragma mark - 私有方法
- (void)loadSubviews
{
    self.tabBar.backgroundImage = [[UIImage imageNamed:@"tabbarBackground"] stretchableImageWithLeftCapWidth:1 topCapHeight:1];
    self.tabBar.selectionIndicatorImage = [[UIImage imageNamed:@"tabbarSelectBg"] stretchableImageWithLeftCapWidth:1 topCapHeight:1];
    
    FirstViewController *fvc = [FirstViewController new];
    fvc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"First"
                                                   image:[UIImage imageNamed:@"tabbar_chats"]
                                           selectedImage:[UIImage imageNamed:@"tabbar_chatsHL"]];
    fvc.tabBarItem.tag = 0;
    fvc.tabBarItem.badgeValue = @"3";
    [self unSelectedTapTabBarItems:fvc.tabBarItem];
    [self selectedTapTabBarItems:fvc.tabBarItem];
    UINavigationController *fnvc = [[UINavigationController alloc] initWithRootViewController:fvc];
    
    SecondViewController *svc = [SecondViewController new];
    svc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Second"
                                                   image:[UIImage imageNamed:@"tabbar_contacts"]
                                           selectedImage:[UIImage imageNamed:@"tabbar_contactsHL"]];
    svc.tabBarItem.tag = 1;
    [self unSelectedTapTabBarItems:svc.tabBarItem];
    [self selectedTapTabBarItems:svc.tabBarItem];
    
    ThirdViewController *tvc = [ThirdViewController new];
    tvc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Third"
                                                   image:[UIImage imageNamed:@"tabbar_setting"]
                                           selectedImage:[UIImage imageNamed:@"tabbar_settingHL"]];
    tvc.tabBarItem.tag = 2;
    [self unSelectedTapTabBarItems:tvc.tabBarItem];
    [self selectedTapTabBarItems:tvc.tabBarItem];
    
    self.viewControllers = @[fnvc, svc, tvc];
    self.selectedIndex = 0;
}

-(void)unSelectedTapTabBarItems:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont systemFontOfSize:14], NSFontAttributeName,
                                        [UIColor whiteColor], NSForegroundColorAttributeName,
                                        nil]
                              forState:UIControlStateNormal];
}

-(void)selectedTapTabBarItems:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont systemFontOfSize:14], NSFontAttributeName,
                                        RGBACOLOR(0x00, 0xac, 0xff, 1), NSForegroundColorAttributeName,
                                        nil]
                              forState:UIControlStateSelected];
}

#pragma mark - UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (item.tag == 0)
    {
        self.title = @"第一个界面";
    } else if (item.tag == 1)
    {
        self.title = @"第二个界面";
    } else if (item.tag == 2)
    {
        self.title = @"第三个界面";
    }
    NSLog(@"%@", item.title);
}
@end
