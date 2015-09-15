//
//  zoneViewController.m
//  QQ空间
//
//  Created by 妖精的尾巴 on 15-8-31.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import "zoneViewController.h"
#import "LHZoneCell.h"
#import "LHMusicsTool.h"
#import "leftDrawerView.h"
#import "AppDelegate.h"
//#import <AVFoundation/AVFoundation.h>

@interface zoneViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property(weak,nonatomic)UITableView* tableView;
/**
 *空间的背景图片BgImage
 */
@property(weak,nonatomic)UIImageView* BgImage;
/**
 *中间导航栏的标题
 */
@property(weak,nonatomic)UILabel* titleLabel;
/**
 *打开左边抽屉的按钮
 */
@property(weak,nonatomic)UIButton* leftDrawerBtn;
/**
 *导航栏右边的黄钻会员按钮
 */
@property(weak,nonatomic)UIButton* rightVipBtn;
/**
 *空间的背景图片bgView
 */
@property(nonatomic,weak)UIView* bgView;
/**
 *存储plist文件数组
 */
@property(nonatomic,strong)NSArray* plistDataArray;
/**
 *记录左边抽屉的属性
 */
@property(nonatomic,weak)UIView* leftDrawerView;
/**
 *用于左边抽屉视图点击返回的遮盖的按钮
 */
@property(nonatomic,strong)UIButton* coverBtn;
/**
 *用于记录左边抽屉视图是否被拉出来
 */
@property(nonatomic,assign)BOOL isShow;

@end

@implementation zoneViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self createTableView];
    [self createBgImageView];
    [self createTitleLabel];
    [self createLeftBtn];
    [self createRightBtn];
    [self loadPlistData];
    self.tableView.rowHeight=328;
    self.view.backgroundColor=[UIColor lightGrayColor];
}
-(void)loadPlistData
{
    NSString* pathFile=[[NSBundle mainBundle]pathForResource:@"qqZoneData.plist" ofType:nil];
    self.plistDataArray=[NSArray arrayWithContentsOfFile:pathFile];
}
#pragma mark - 以下五个方法搭建UI界面
-(void)createTableView
{
    UITableView* tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-49)];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.contentInset=UIEdgeInsetsMake(200, 0, 0, 0);
    self.tableView=tableView;
    [self.view addSubview:tableView];
}
-(void)createBgImageView
{
    /**
     *创建用户空间背景图片
     */
    UIImageView* BgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, -200, 320, 200)];
    BgImage.image=[UIImage imageNamed:@"love.jpg"];
    self.BgImage=BgImage;
    [self.tableView addSubview:BgImage];
    /**
     *创建用户空间背景图片的容器View
     */
    UIView*  bgView=[[UIView alloc]init];
    bgView.backgroundColor=[UIColor clearColor];
    bgView.frame=CGRectMake(0, -200, 320, 200);
    self.bgView=bgView;
    [self.tableView addSubview:bgView];
    /**
     *创建用户空间背景头像
     */
    UIImageView* qqImageView=[[UIImageView alloc]initWithFrame:CGRectMake(30, 116, 60, 60)];
    qqImageView.image=[UIImage imageNamed:@"girl.jpg"];
    qqImageView.layer.cornerRadius=30;
    qqImageView.layer.masksToBounds=YES;
    [self.bgView addSubview:qqImageView];
    /**
     *创建背景图上的圆形头像下面的底部衬托
     */
    UIImageView* Image=[[UIImageView alloc]initWithFrame:CGRectMake(26, 151, 68, 40)];
    Image.image=[UIImage imageNamed:@"yellowdiamond_riband"];
    [self.bgView addSubview:Image];
}
-(void)createTitleLabel
{
    UILabel* titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.textColor=[UIColor blackColor];
    titleLabel.text=@"全部动态";
    titleLabel.textAlignment=NSTextAlignmentCenter;
    self.navigationItem.titleView=titleLabel;
    titleLabel.alpha=0.0f;
    self.titleLabel=titleLabel;
}
-(void)createLeftBtn
{
    UIButton* leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0,0,55,44)];
    [leftBtn setImage:[UIImage imageNamed:@"nav_icon_l_menu"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.leftDrawerBtn=leftBtn;
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:self.leftDrawerBtn];
    
    self.navigationItem.leftBarButtonItem=leftItem;
}
-(void)createRightBtn
{
    UIButton* rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(0,0,20,20)];
    [rightBtn setImage:[UIImage imageNamed:@"big_diamond_stone"] forState:UIControlStateNormal];
    self.rightVipBtn=rightBtn;
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:self.rightVipBtn];
    self.navigationItem.rightBarButtonItem=rightItem;
}
#pragma mark - 打开左边抽屉按钮响应事件
-(void)leftBtnAction
{
    NSLog(@"左边按钮点击");
    
    self.coverBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 375,667)];
    self.coverBtn.backgroundColor=[UIColor blackColor];
    self.coverBtn.alpha=0.6;
    [UIView animateWithDuration:1.0f delay:0.5f options: UIViewAnimationOptionAllowAnimatedContent  animations:^{
      
        [self.coverBtn addTarget:self action:@selector(removeCoverBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.coverBtn];
        
        self.leftDrawerView=[[[NSBundle mainBundle]loadNibNamed:@"leftDrawerView" owner:nil options:nil]lastObject];
        [self.view.window addSubview:self.coverBtn];
        [self.view.window addSubview:self.leftDrawerView];
//        [self.view.window insertSubview:self.coverBtn aboveSubview:self.view];
        //[self.leftDrawerView insertSubview:self.coverBtn aboveSubview:self.view];
        self.navigationController.navigationBarHidden=YES;

       
        self.isShow=YES;
            } completion:^(BOOL finished) {
        NSLog(@"动画完成");
    }];
}
#pragma mark - 移除遮盖的方法
-(void)removeCoverBtn
{
    [UIView animateWithDuration:0.6f animations:^{
        if (self.isShow)
        {
            self.leftDrawerView.hidden=YES;
            self.coverBtn.hidden=YES;
            self.isShow=NO;
            self.navigationController.navigationBarHidden=NO;
        }
        else{
            self.leftDrawerView.hidden=NO;
            self.coverBtn.hidden=NO;
            self.isShow=YES;
            self.navigationController.navigationBarHidden=YES;
        }

    }];
}

#pragma mark - UITableViewDataSource代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.plistDataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellID=@"cell";
    LHZoneCell* cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"LHZoneCell" owner:nil options:nil] lastObject];
    }
    NSDictionary* dict=self.plistDataArray[indexPath.row];
    cell.separatorInset=UIEdgeInsetsMake(0, 30, 0, 0);
    cell.userIcon.image=[UIImage imageNamed:dict[@"userIcon"]];
    cell.usernickName.text=dict[@"userName"];
    cell.userPubulishTime.text=dict[@"userPubulishTime"];
    cell.userContentLabel.text=dict[@"userContentlabel"];
    cell.userbrowseLabel.text=dict[@"userbrowseLabel"];
    cell.userPhoneSource.text=dict[@"userPhoneSource"];
    cell.userAppreciateNumbers.text=dict[@"userAppreciateNumbers"];
    cell.userContentImage.image=[UIImage imageNamed:dict[@"userContentImage"]];
    return cell;
}
#pragma mark - UIScrollViewdelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset  = scrollView.contentOffset.y;
    CGFloat xOffset = (yOffset + 200)/2;
    
    if (yOffset < -200) {
        
        CGRect rect = self.BgImage.frame;
        rect.origin.y = yOffset;
        rect.size.height =  -yOffset ;
        rect.origin.x = xOffset;
        rect.size.width = 320 + fabs(xOffset)*2;
        self.BgImage.frame = rect;
    }
    
    CGFloat alpha = (yOffset+200)/200;
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[[UIColor greenColor]colorWithAlphaComponent:alpha]] forBarMetrics:UIBarMetricsDefault];
    self.titleLabel.alpha=alpha;
    alpha=fabs(alpha);
    alpha=fabs(1-alpha);
    
    alpha=alpha<0.2? 0:alpha-0.1;
    
    self.bgView.alpha=alpha;
}
- (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中的颜色
    //[LHMusicsTool playMusic:@"suc.wav"];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView endEditing:YES];
}

@end
