//
//  RootViewController.m
//  CommonFramework
//
//  Created by dengtao on 16/3/30.
//  Copyright © 2016年 shengzhong. All rights reserved.
//

#import "RootViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"

@interface RootViewController()
@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupSubviews];
}

- (void)setupSubviews
{
    FirstViewController *firstVC = [[FirstViewController alloc] init];
    UINavigationController *firstNC = [[UINavigationController alloc] initWithRootViewController:firstVC];
    
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    UINavigationController *secondNC = [[UINavigationController alloc] initWithRootViewController:secondVC];
    
    ThirdViewController *thirdVC = [[ThirdViewController alloc] init];
    UINavigationController *thirdNC = [[UINavigationController alloc] initWithRootViewController:thirdVC];
    
    FourthViewController *fourthVC = [[FourthViewController alloc] init];
    UINavigationController *fourthNC = [[UINavigationController alloc] initWithRootViewController:fourthVC];
    
    // 导航视图集合
    self.viewControllers = @[firstNC, secondNC, thirdNC, fourthNC];
    // 未选中的图片名集合
    NSArray *unselectImageNames = @[@"first_tabbar_unselect", @"second_tabbar_unselect", @"second_tabbar_unselect", @"fourth_tabbar_unselect"];
    // 选中的图片名集合
    NSArray *selectedImageNames = @[@"first_tabbar_selected", @"second_tabbar_selected", @"second_tabbar_selected", @"fourth_tabbar_selected"];
    
    NSArray *titleArray = @[@"第一", @"第二", @"第三", @"第四"];
    
    for (int i = 0; i < self.viewControllers.count; i++)
    {
        UINavigationController *tempNC = self.viewControllers[i];
        UIViewController *tempVC = tempNC.topViewController;
        tempVC.title = titleArray[i];
        
        UIImage *unselectImage = [UIImage imageNamed:unselectImageNames[i]];
        UIImage *selectedImage = [UIImage imageNamed:selectedImageNames[i]];
        
        unselectImage = [unselectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self unSelectedTapTabBarItems:tempVC.tabBarItem];
        [self selectedTapTabBarItems:tempVC.tabBarItem];
        
        tempNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:titleArray[i] image:unselectImage selectedImage:selectedImage];
        tempNC.navigationBar.barTintColor = TABBARCOLOR_NOR;
        [self unSelectedTapTabBarItems:tempNC.tabBarItem];
        [self selectedTapTabBarItems:tempNC.tabBarItem];
    }
    
    [self selectedTapTabBarItems:firstVC.tabBarItem];
}

-(void)unSelectedTapTabBarItems:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIFont systemFontOfSize:14], NSFontAttributeName,[UIColor grayColor],NSForegroundColorAttributeName, nil]
                              forState:UIControlStateNormal];
}

-(void)selectedTapTabBarItems:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIFont systemFontOfSize:14], NSFontAttributeName,[UIColor redColor],NSForegroundColorAttributeName, nil]
                              forState:UIControlStateSelected];
}
@end
