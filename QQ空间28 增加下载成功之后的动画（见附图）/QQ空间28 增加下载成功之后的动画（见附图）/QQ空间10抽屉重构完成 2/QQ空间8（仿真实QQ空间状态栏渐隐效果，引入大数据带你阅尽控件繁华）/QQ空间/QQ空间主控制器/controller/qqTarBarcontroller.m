//
//  LHMainViewController.m
//  QQ空间
//
//  Created by 妖精的尾巴 on 15-9-1.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import "qqTarBarController.h"
#import "zoneViewController.h"
#import "MeViewController.h"
#import "CerterViewController.h"
#import "mySpaceViewController.h"
#import "playViewController.h"
#import "LHTabBar.h"
#import "CerterViewController.h"
#import "UIImage+Extesion.h"

#define TabarHeight 49

@interface qqTarBarController ()<LHTabBarDelegate>

@property(nonatomic,strong)UIImageView* selectedImage;

@end

@implementation qqTarBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.初始化子控制器
    zoneViewController *zone = [[zoneViewController alloc] init];
    [self addChildVc:zone title:@"动态" image:@"tabbar_icon_auth" selectedImage:@"tabbar_icon_auth_click"];
    
    MeViewController *me = [[MeViewController alloc] init];
    [self addChildVc:me title:@"与我相关" image:@"tabbar_icon_at" selectedImage:@"tabbar_icon_at_click"];
    
    mySpaceViewController *mySpace = [[mySpaceViewController alloc] init];
    [self addChildVc:mySpace title:@"我的空间" image:@"tabbar_icon_space" selectedImage:@"tabbar_icon_space_click"];
    
    playViewController *play = [[playViewController alloc] init];
    [self addChildVc:play title:@"玩吧" image:@"tabbar_icon_more" selectedImage:@"tabbar_icon_more_click"];
    
    LHTabBar *tabBar = [[LHTabBar alloc] init];
    tabBar.delegate = self;
    [self setValue:tabBar forKeyPath:@"tabBar"];

   
}
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.title = title; // 同时设置tabbar和navigationBar的文
    
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    // 添加为子控制器
    [self addChildViewController:nav];
}

#pragma mark - HWTabBarDelegate代理方法
- (void)tabBarDidClickPlusButton:(LHTabBar *)tabBar
{
    CerterViewController *vc = [[CerterViewController alloc] init];
    vc.captureImage=[UIImage imageWithCaputureView:self.view];
    [self presentViewController:vc animated:NO completion:nil];
}

@end
