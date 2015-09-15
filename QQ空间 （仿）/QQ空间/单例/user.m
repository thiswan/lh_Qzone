//
//  user.m
//  QQ空间
//
//  Created by 妖精的尾巴 on 15-8-29.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import "user.h"

@implementation user

#define UserKey @"user"
#define PwdKey @"pwd"

singleton_implementation(user)

//-(void)setUserInfo:(NSDictionary *)userInfo
//{
//    NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
//    [user setObject:userInfo forKey:@"USER_INFO"];
//    [user synchronize];
//}
//
////-(void)setUserPwdInfo:(NSDictionary *)userPwdInfo
////{
////    NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
////    [user setObject:userPwdInfo forKey:@"USER_PWD_INFO"];
////    [user synchronize];
////}
//
//-(NSDictionary *)GetUserInfo
//{
//    NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
//    return [user dictionaryForKey:@"USER_INFO"];
//}
//
////-(NSDictionary *)GetUserPwdInfo
////{
////    NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
////    return [user dictionaryForKey:@"USER_PWD_INFO"];
////}
//
//
//-(void)clearUserInfo
//{
//    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
//    [user removeObjectForKey:@"USER_INFO"];
//    [user synchronize];
//}
-(void)saveUserInfoToSanbox{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.user forKey:UserKey];
    [defaults setObject:self.pwd forKey:PwdKey];
    [defaults synchronize];
    
}

-(void)loadUserInfoFromSanbox{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.user = [defaults objectForKey:UserKey];
    self.pwd = [defaults objectForKey:PwdKey];
}

@end
