//
//  settingViewController.m
//  QQ空间
//
//  Created by 妖精的尾巴 on 15-9-3.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import "settingViewController.h"
#import "ViewController.h"
#import "user.h"
#import "LHMusicsTool.h"
#import "UIBarButtonItem+Extesion.h"
#import "qqButton.h"
#import "aboutQQViewController.h"
@interface settingViewController ()<UIAlertViewDelegate>
/**
 *缓冲界面（菊花界面）
 */
@property(nonatomic,strong)UIActivityIndicatorView* actIndView;
@end

@implementation settingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"设置";
    //self.view.backgroundColor=[UIColor cyanColor];
    
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem initWithTitle:@"帮助" titleColor:[UIColor blackColor] target:self action:nil];
    
    self.userIcon.layer.cornerRadius=27;
    self.userIcon.layer.masksToBounds=YES;
    
    [self createBtn];
    
}
-(void)createBtn
{
    qqButton* firstBtn=[qqButton buttonWithType:UIButtonTypeCustom];
    [firstBtn setImage:[UIImage imageNamed:@"myspace_weibo"] forState:UIControlStateNormal];
    firstBtn.frame=CGRectMake(0, 141, 107, 69);
    [firstBtn setBackgroundColor:[UIColor lightGrayColor]];
    [firstBtn setTitle:@"通用设置" forState:UIControlStateNormal];
    [firstBtn setBorderWidth:1.0f andColor:[UIColor grayColor]];
    [self.view addSubview:firstBtn];
    
    qqButton* secondBtn=[qqButton buttonWithType:UIButtonTypeCustom];
    [secondBtn setImage:[UIImage imageNamed:@"myspace_msg"] forState:UIControlStateNormal];
    secondBtn.frame=CGRectMake(107, 141, 106, 69);
    [secondBtn setBackgroundColor:[UIColor lightGrayColor]];
    [secondBtn setTitle:@"权限隐私" forState:UIControlStateNormal];
    [secondBtn setBorderWidth:1.0f andColor:[UIColor grayColor]];
    [self.view addSubview:secondBtn];

    qqButton* threeBtn=[qqButton buttonWithType:UIButtonTypeCustom];
    [threeBtn setImage:[UIImage imageNamed:@"myspace_msg"] forState:UIControlStateNormal];
    threeBtn.frame=CGRectMake(213, 141, 107, 69);
    [threeBtn setBackgroundColor:[UIColor lightGrayColor]];
    [threeBtn setTitle:@"消息通知" forState:UIControlStateNormal];
    [threeBtn setBorderWidth:1.0f andColor:[UIColor grayColor]];
    [self.view addSubview:threeBtn];
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)quitBtnAction {
    UIAlertView* alter=[[UIAlertView alloc]initWithTitle:@"退出登录" message:@"退出后，你将无法收到推送通知。确定要退出当前登陆账号吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alter show];
}

- (IBAction)aboutQQClick {
    aboutQQViewController* aboutVc=[[aboutQQViewController alloc]init];
    [self.navigationController  pushViewController:aboutVc animated:YES];
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        self.actIndView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [UIView animateWithDuration:5.0f animations:^{
            /**
             *添加蒙版时注册时等候界面(菊花界面)
             */
            self.actIndView.frame=CGRectMake(150,300,40,40);
            [self.view addSubview:self.actIndView];
            [self.actIndView startAnimating];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1.0f delay:0.7 options:UIViewAnimationOptionTransitionFlipFromBottom  animations:^{
                [self.actIndView stopAnimating];
                [self.actIndView removeFromSuperview];
                ViewController* vc=[[ViewController alloc]init];
                self.view.window.rootViewController=vc;
                vc.qqNumField.text=[user shareduser].user;
            } completion:^(BOOL finished) {
                NSLog(@"动画完成,用户退出空间");
                [LHMusicsTool playMusic:@"login.wav"];
            }];
        }];
    }

}
@end
