//
//  LQMainViewController.m
//  Spice
//
//  Created by lanou3g on 16/4/14.
//  Copyright © 2016年 spice. All rights reserved.
//

#import "LQMainViewController.h"
#import "LQNavigationController.h"
#import "LQHomeViewController.h"
#import "LQJokeTableViewController.h"
#import "LQMineViewController.h"
#import "LQVedioViewController.h"
@interface LQMainViewController ()

@end

@implementation LQMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    LQHomeViewController *home = [[LQHomeViewController alloc] init];
    [self addChildVC:home title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    LQVedioViewController *vedio = [[LQVedioViewController alloc] init];
    [self addChildVC:vedio title:@"视频" image:@"tabbar_discover" selectedImage:@"tabbar_discoverHL"];
    LQJokeTableViewController *joke = [[LQJokeTableViewController alloc] init];
    [self addChildVC:joke title:@"段子" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    LQMineViewController *mine = [[LQMineViewController alloc] init];
    [self addChildVC:mine title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    
    
    
}


- (void)addChildVC:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    
    childVC.title = title;
    //设置子控制器图片
    childVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //设置文字样式
    NSMutableDictionary *textAtrrs = [NSMutableDictionary dictionary];
    textAtrrs[NSForegroundColorAttributeName] = LQColor(120, 120, 120);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVC.tabBarItem setTitleTextAttributes:textAtrrs forState:UIControlStateNormal];
    [childVC.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    LQNavigationController *lqnav = [[LQNavigationController alloc] initWithRootViewController:childVC];
    
    [self addChildViewController:lqnav];
    
}



@end
