//
//  ViewController.h
//  QQ空间登录
//
//  Created by 妖精的尾巴 on 15-8-19.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
/**
 *登录QQ号码密码的输入框
 */
@property(nonatomic,strong)UITextField* qqField;
/**
 *登录QQ号码的输入框
 */
@property(nonatomic,strong)UITextField* qqNumField;
/**
 *登录QQ按钮
 */
@property(nonatomic,strong)UIButton* loginBtn;
/**
 *登录QQ图片imageView
 */
@property(nonatomic,strong)UIImageView* imageView;
/**
 *登录QQ文字图片imageView
 */
@property(nonatomic,strong)UIImageView* qqImageView;
/**
 *用于添加蒙版的按钮
 */
@property(nonatomic,strong)UIButton* coverBtn;
/**
 *缓冲界面（菊花界面）
 */
@property(nonatomic,strong)UIActivityIndicatorView* actIndView;
/**
 *用来模拟根服务器对接的速度（也就是模拟当前网速，本次模拟没有考虑链接失败的情况）
 */
@property(nonatomic,strong)NSTimer* timer;
/**
 *定时器变量
 */
@property(nonatomic,assign)int i;
/**
 *字典保存用户qq号码信息
 */
@property(nonatomic,strong)NSDictionary *userInfo;
/**
 *字典保存用户qq密码信息
 */
@property(nonatomic,strong)NSDictionary *userPwdInfo;
/**
 *创建输入号码时下拉按钮
 */
@property(weak,nonatomic)UIButton* btn;

@end
