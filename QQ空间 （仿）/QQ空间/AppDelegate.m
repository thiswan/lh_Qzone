//
//  AppDelegate.m
//  QQ空间
//
//  Created by 妖精的尾巴 on 15-8-23.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import "AppDelegate.h"
#import "user.h"
#import "UIWindow+Extesion.h"
#import "zoneViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /**
     *打印沙盒路径，为后面下载背景音乐做好准备
     */
    NSString* path=[NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"下载背景音乐的沙盒路径为：%@",path);
    /**
     *1-----让启动界面停留一秒
     */
    [NSThread sleepForTimeInterval:1.0f];
    /**
     *2-----加载沙盒数据
     */
    [[user shareduser] loadUserInfoFromSanbox];
    /**
     *3-----切换根控制器
     */
    [self.window switchRootViewController];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
