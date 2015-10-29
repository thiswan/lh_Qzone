//
//  ViewController.m
//  QQ空间登录
//
//  Created by 妖精的尾巴 on 15-8-19.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import "ViewController.h"
#import "RegisterViewController.h"
#import "zoneViewController.h"
#import "user.h"
#import "LHButton.h"
#import "LHMusicsTool.h"
#import "qqTarBarController.h"
//#import <AVFoundation/AVFoundation.h>
@interface ViewController ()<UITextFieldDelegate>
/**
 *创建号码框与密码框之间的分割线
 */
@property(nonatomic,weak)UIImageView* lineview;
@property(nonatomic,weak)UIImageView* lineview2;
/**
 *下拉按钮是否被点击
 */
@property(assign,nonatomic)BOOL isDropDown;
/**
 *自定义的下拉按钮提示框
 */
@property(nonatomic,weak)LHButton* dropDownBtn;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor lightGrayColor];
    [self createImageView];
    [self createTextField];
    [self creataloginBtn];
    [self createRegisterBtn];
    [self createLookingForPwdBtn];
    [self createLine];
    [self createMenuBtn];
    //[self registerQQ];
}
/**
 *把注册后的QQ号传到QQ号码框，密码需要用户自己输入
 */
-(void)registerQQ
{
//    NSLog(@"来到了registerQQ这个方法");
//    self.userInfo=[[user shareduser] GetUserInfo];
//     if (!self.userInfo) {
//        NSLog(@"用户还没有注册");
//     }
//     else{
//         
//         NSString *username = [_userInfo objectForKey:@"username"];
//         self.qqNumField.text=username;
//         NSLog(@"注册过后的用户QQ号:%@",self.qqNumField.text);
//     }

}
/**
 *创建空间背景图片
 */
-(void)createImageView
{
    UIImageView* bgImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login-bg.jpg"]];
    [self.view addSubview:bgImage];
    
    self.imageView=[[UIImageView alloc]initWithFrame:CGRectMake(100, 20, 125, 129)];
    self.imageView.image=[UIImage imageNamed:@"bg_login_logo@2x"];
    [bgImage addSubview:self.imageView];
    
    self.qqImageView =[[UIImageView alloc]initWithFrame:CGRectMake(100, 160, 125, 40)];
    self.qqImageView.image=[UIImage imageNamed:@"bg_login_qzone@2x"];
    [bgImage addSubview:self.qqImageView];
}
/**
 *创建号码框与密码框之间的分割线
 */
-(void)createLine
{
    UIImageView* lineview=[[UIImageView alloc]initWithFrame:CGRectMake(15, 250, 292, 1)];
    lineview.image=[UIImage imageNamed:@"location_searchbox_bg@2x"];
    [self.view addSubview:lineview];
    self.lineview=lineview;
    
    UIImageView* lineview2=[[UIImageView alloc]initWithFrame:CGRectMake(15, 290, 292, 1)];
    lineview2.image=[UIImage imageNamed:@"location_searchbox_bg@2x"];
    [self.view addSubview:lineview2];
    self.lineview2=lineview2;

}
/**
 *创建号码框与密码框之间的分割线后面的菜单按钮
 */
-(void)createMenuBtn
{
    UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(282, 220, 14, 9);
    [btn setImage:[UIImage imageNamed:@"icon_purview_arrows_pulldown@2x"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(dropDownBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.isDropDown=YES;
    btn.hidden=YES;
    self.btn=btn;
}
#pragma mark - 下拉菜单按钮点击事件
-(void)dropDownBtnClick
{
    if (self.isDropDown) {
        NSLog(@"按钮被点击,向上");
         self.isDropDown=NO;
         [self.btn setImage:[UIImage imageNamed:@"icon_purview_arrows_receipts@2x"] forState:UIControlStateNormal];
         LHButton* dropDownBtn=[[LHButton alloc]initWithFrame:CGRectMake(15, 252, 292, 40)];
         [dropDownBtn setBackgroundImage:[UIImage imageNamed:@"1234.png"] forState:UIControlStateNormal];
         [dropDownBtn setImage:[UIImage imageNamed:@"girl.jpg"] forState:UIControlStateNormal];
         NSString* text=[user shareduser].user;
         [dropDownBtn setTitle:text forState:UIControlStateNormal];
        [dropDownBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
         [self.view addSubview:dropDownBtn];
         self.dropDownBtn=dropDownBtn;
#warning 这里下拉按钮位置有小bug，不能正确复位（8.31早上）
        /**
         *密码输入框，分割线，登录按钮都要下移40个单位
         */
        self.qqField.frame=CGRectMake(15, 254, 252, 35);
        self.lineview2.frame=CGRectMake(15, 290, 292, 1);
        self.loginBtn.frame=CGRectMake(15, 320, 292, 40);
        dropDownBtn.frame=CGRectMake(15,200, 292,40);
    }
    else{
        NSLog(@"按钮被点击,向下");
        [self.btn setImage:[UIImage imageNamed:@"icon_purview_arrows_pulldown@2x"] forState:UIControlStateNormal];
        [self.dropDownBtn removeFromSuperview];
        self.isDropDown=YES;

        self.qqNumField.frame=CGRectMake(15, 210, 292, 44);
        self.qqField.frame=CGRectMake(15, 252, 292, 44);
        self.loginBtn.frame=CGRectMake(15, 320, 292, 40);
        self.lineview.frame=CGRectMake(15, 250, 292, 1);
        self.lineview2.frame=CGRectMake(15, 290, 292, 1);
    }
}
/**
 *创建账号密码框
 */
-(void)createTextField
{
    self.qqNumField=[[UITextField alloc]initWithFrame:CGRectMake(15, 210, 252, 35)];
    self.qqNumField.borderStyle=UITextBorderStyleNone;
    self.qqNumField.background=[UIImage imageNamed:@"bg_login_top@2x"];
    self.qqNumField.placeholder=@"QQ号/手机号/邮箱";
    self.qqNumField.keyboardType=UIKeyboardTypeNumberPad;
    self.qqNumField.clearButtonMode= UITextFieldViewModeWhileEditing;
    self.qqNumField.delegate=self;
    [self.view addSubview:self.qqNumField];
    
    self.qqField=[[UITextField alloc]initWithFrame:CGRectMake(15, 254, 252, 35)];
    self.qqField.borderStyle=UITextBorderStyleNone;
    self.qqField.keyboardType=UIKeyboardTypeNumberPad;
    self.qqField.background=[UIImage imageNamed:@"bg_login_bottom@2x"];
    self.qqField.placeholder=@"密码";
    self.qqField.clearButtonMode= UITextFieldViewModeWhileEditing;
    self.qqField.delegate=self;
    self.qqField.secureTextEntry=YES;
    [self.view addSubview:self.qqField];
}
/**
 *创建登录按钮
 */
-(void)creataloginBtn
{
    self.loginBtn=[[UIButton alloc]initWithFrame:CGRectMake(15, 320, 292, 40)];
    self.loginBtn.layer.cornerRadius=20;
    self.loginBtn.layer.masksToBounds=YES;
    UIImage* image=[UIImage imageNamed:@"btn_login_login@2x"];
    int leftCap = image.size.width * 0.5;
    int topCap = image.size.height * 0.5;
    UIImage* stretchImage= [image stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
    [self.loginBtn setBackgroundImage:stretchImage forState:UIControlStateNormal];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
}
/**
 *创建注册按钮
 */
-(void)createRegisterBtn
{
    UIButton* registerbtn=[[UIButton alloc]initWithFrame:CGRectMake(210,520, 110, 40)];
    [registerbtn setTitle:@"新用户" forState:UIControlStateNormal];
    [registerbtn setTintAdjustmentMode: UIViewTintAdjustmentModeAutomatic];
    [registerbtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerbtn];
}
/**
 *创建找回密码按钮
 */
-(void)createLookingForPwdBtn
{
    UIButton* registerbtn=[[UIButton alloc]initWithFrame:CGRectMake(15,520, 110, 40)];
    [registerbtn setTitle:@"找回密码" forState:UIControlStateNormal];
    [registerbtn setTintAdjustmentMode: UIViewTintAdjustmentModeAutomatic];
    //[registerbtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerbtn];
}

/**
 *登录按钮点击事件
 */
-(void)loginBtnClick
{
    [self.qqNumField resignFirstResponder];
    [self.qqField resignFirstResponder];
    NSLog(@"用户点击了登录按钮");
    if (self.qqNumField.text.length==0 && self.qqField.text.length==0)
    {
        UIAlertView* alter=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"亲，输入你的账号密码就可以登录咯" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alter show];
    }
    else
    {
        if ([self.qqNumField.text isEqualToString:[user shareduser].user]&&[self.qqField.text isEqualToString:[user shareduser].pwd])
        {
            [self loginSuccess];
        }
        else
        {
            UIAlertView* alter=[[UIAlertView alloc]initWithTitle:@"很抱歉" message:@"亲，你输入的账号或者密码有误" delegate:nil cancelButtonTitle:@"我看一下" otherButtonTitles:@"重新输入", nil];
            [alter show];
        }
    }
}
/**
 *登录成功时候调用该方法
 */
-(void)loginSuccess
{
    self.i++;
    for (int j=0; j<5; j++) {
        NSLog(@"纯粹是为了模拟网速，延长登录时间");
    }
    [self createCoverBtn];
    [self createActivityIndicatorView];
    self.timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
}
/**
 *添加蒙版的按钮方法
 */
-(void)createCoverBtn
{
    self.coverBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.coverBtn.backgroundColor=[UIColor blackColor];
    [self.coverBtn setTitle:@"正在登录中。。。" forState:UIControlStateNormal];
    self.coverBtn.alpha=0.3;
    [self.view addSubview:self.coverBtn];
}
/**
 *添加蒙版时注册时等候界面(菊花界面)
 */
-(void)createActivityIndicatorView
{
    self.actIndView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.actIndView.frame=CGRectMake(140,235,40,40);
    [self.coverBtn addSubview:self.actIndView];
    [self.actIndView startAnimating];
}
/**
 *定时器响应方法
 */
-(void)timerAction:(NSTimer*)timer
{
    NSLog(@"登录控制器正在调用定时器方法");
    self.i++;
    for (int j=0; j<5; j++) {
        NSLog(@"正在登录中");
    }
    if (self.i==5) {
        [timer invalidate];
        timer=nil;
        [self UntilSeccessDone];
        NSLog(@"登录完成");
       }
}
/**
 *登陆成功后调用的方法
 */
-(void)UntilSeccessDone
{
    [self.actIndView stopAnimating];
    [self.coverBtn removeFromSuperview];
    NSLog(@"用户登录成功");
    /**
     *1-----给zoneViewController设为导航控制器的根控制器
     *2-----设置当前View的窗口的根控制器为导航控制器
     */
    [UIView animateWithDuration:1.5f delay:0.3f options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
//        zoneViewController* zoneVc=[[zoneViewController alloc]init];
//        UINavigationController* nav=[[UINavigationController alloc]initWithRootViewController:zoneVc];
        qqTarBarController* qqVc=[[qqTarBarController alloc]init];
        self.view.window.rootViewController=qqVc;
    } completion:^(BOOL finished) {
       // [LHMusicsTool playMusic:@"login.wav"];
    }];
   
}
/**
 *注册按钮点击事件
 */
-(void)registerBtnClick
{
    RegisterViewController* registerVc=[[RegisterViewController alloc]init];
    [self presentViewController:registerVc animated:YES completion:^{
        self.qqNumField.text=@"";
        self.qqNumField.text=@"";
    }];
}
/**
 *键盘退下事件的处理
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.dropDownBtn removeFromSuperview];
    [self.view endEditing:YES];
}
#pragma mark - UITextFieldDelegate代理方法---监听用户输入文字信息
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"调用了textFieldDidBeginEditing--开始编辑");
   // [LHMusicsTool playMusic:@"pull.wav"];
    self.btn.hidden=NO;
    [self changeframe];
}
-(void)changeframe
{
    self.imageView.frame=CGRectMake(30, 60, 50,50);
    self.qqImageView.frame=CGRectMake(95, 60, 145, 55);
    self.qqNumField.frame=CGRectMake(15, 142, 252, 44);
    self.qqField.frame=CGRectMake(15, 186, 252, 44);
    self.loginBtn.frame=CGRectMake(15, 240, 292, 40);
    self.lineview.frame=CGRectMake(15, 184, 292, 1);
    self.lineview2.frame=CGRectMake(15, 224, 292, 1);
    self.btn.frame=CGRectMake(270, 152, 14, 9);

}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"调用了textFieldDidEndEditing--结束编辑");
    self.btn.hidden=YES;
    [self resetframe];
}
-(void)resetframe
{
    self.imageView.frame=CGRectMake(100, 20, 125, 129);
    self.qqImageView.frame=CGRectMake(100, 160, 125, 40);
    self.qqNumField.frame=CGRectMake(15, 210, 292, 44);
    self.qqField.frame=CGRectMake(15, 252, 292, 44);
    self.loginBtn.frame=CGRectMake(15, 320, 292, 40);
    self.lineview.frame=CGRectMake(15, 250, 292, 1);
    self.lineview2.frame=CGRectMake(15, 290, 292, 1);
    //self.btn.frame=CGRectMake(282, 220, 14, 9);
}
@end
