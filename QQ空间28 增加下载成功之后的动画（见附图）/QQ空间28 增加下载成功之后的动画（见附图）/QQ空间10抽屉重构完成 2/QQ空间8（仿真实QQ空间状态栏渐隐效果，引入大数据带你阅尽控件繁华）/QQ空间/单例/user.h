//
//  user.h
//  QQ空间
//
//  Created by 妖精的尾巴 on 15-8-29.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface user : NSObject

singleton_interface(user);

/**
 *用户名
 */
@property (nonatomic, copy) NSString *user;
/**
 *用户密码
 */
@property (nonatomic, copy) NSString *pwd;

//-(void)setUserInfo:(NSDictionary *)userInfo;
//
////-(void)setUserPwdInfo:(NSDictionary *)userPwdInfo;
//
//-(NSDictionary *)GetUserInfo;
//
////-(NSDictionary *)GetUserPwdInfo;
//
//-(void)clearUserInfo;
/**
 *  从沙盒里获取用户数据
 */
-(void)loadUserInfoFromSanbox;

/**
 *  保存用户数据到沙盒
 
 */
-(void)saveUserInfoToSanbox;
@end
