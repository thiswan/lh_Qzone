//
//  UIWindow+Extesion.m
//  我的常用分类
//
//  Created by 妖精的尾巴 on 15-8-5.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import "UIWindow+Extesion.h"
#import "ViewController.h"
#import "NewVersionViewController.h"

@implementation UIWindow (Extesion)

- (void)switchRootViewController
{
    //NSString* info=[NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    //NSLog(@"%@",info);
    NSString *key = @"CFBundleVersion";
    // 上一次的使用版本（存储在沙盒中的版本号）
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    // 当前软件的版本号（从Info.plist中获得）
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
#warning 这个UITableViewController可能随时需要变换，这里只是为了消除警告才这么写的，下面同理，根据实际需要切换根控制器
    if ([currentVersion isEqualToString:lastVersion])
      {
        self.rootViewController = [[ViewController alloc] init];
      }
     else
        {
        self.rootViewController = [[NewVersionViewController alloc] init];
        // 将当前的版本号存进沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        }
}
@end
