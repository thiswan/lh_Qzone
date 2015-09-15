//
//  mySpaceViewController.m
//  QQ空间
//
//  Created by 妖精的尾巴 on 15-9-1.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import "mySpaceViewController.h"
#import "mySpaceCell.h"
#import "qqBackgroundMusicViewController.h"
#import "SettingViewController.h"
#import "loverViewController.h"


@interface mySpaceViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property(weak,nonatomic)UITableView* tableView;
/**
 *空间的背景图片BgImage
 */
@property(weak,nonatomic)UIImageView* BgImage;
/**
 *空间的背景图片bgView
 */
@property(nonatomic,weak)UIView* bgView;
/**
 *中间导航栏的标题
 */
@property(weak,nonatomic)UILabel* titleLabel;
/**
 *导航栏右边的好友按钮
 */
@property(weak,nonatomic)UIButton* goodFriendBtn;
/**
 *左边设置的按钮
 */
@property(nonatomic,weak)UIButton* settingBtn;
/**
 *存储plist文件数组
 */
@property(nonatomic,strong)NSArray* plistDataArray;


@end

@implementation mySpaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor greenColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self createTableView];
    [self createBgImageView];
    [self createLeftBtn];
    [self createRightBtn];
    [self createTitleLabel];
    [self loadPlistData];
}
-(void)loadPlistData
{
    NSString* pathFile=[[NSBundle mainBundle]pathForResource:@"mySpace.plist" ofType:nil];
    self.plistDataArray=[NSArray arrayWithContentsOfFile:pathFile];
}

#pragma mark - 以下五个方法搭建UI界面
-(void)createTableView
{
    UITableView* tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 520)];
    self.tableView=tableView;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.contentInset=UIEdgeInsetsMake(200, 0, 0, 0);
    
    self.tableView.rowHeight=65;
    [self.view addSubview:self.tableView];
}
-(void)createBgImageView
{
    /**
     *创建用户空间背景图片的容器View
     */
    UIView*  bgView=[[UIView alloc]init];
    bgView.frame=CGRectMake(0, -200, 320, 200);
    self.bgView=bgView;
    [self.tableView addSubview:self.bgView];
    /**
     *创建用户空间背景图片
     */
    UIImageView* BgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, -200, 320, 200)];
    BgImage.image=[UIImage imageNamed:@"love.jpg"];
    self.BgImage=BgImage;
    [self.tableView addSubview:self.BgImage];
    /**
     *创建用户空间背景头像
     */
    UIImageView* qqImageView=[[UIImageView alloc]initWithFrame:CGRectMake(30, 116, 60, 60)];
    qqImageView.image=[UIImage imageNamed:@"girl.jpg"];
    qqImageView.layer.cornerRadius=30;
    qqImageView.layer.masksToBounds=YES;
    [self.BgImage addSubview:qqImageView];
    /**
     *创建背景图上的圆形头像下面的底部衬托
     */
    UIImageView* Image=[[UIImageView alloc]initWithFrame:CGRectMake(26, 151, 68, 40)];
    Image.image=[UIImage imageNamed:@"yellowdiamond_riband"];
    [self.BgImage addSubview:Image];
}
-(void)createTitleLabel
{
    UILabel* titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.textColor=[UIColor blackColor];
    titleLabel.text=@"我的空间";
    titleLabel.textAlignment=NSTextAlignmentCenter;
    self.navigationItem.titleView=titleLabel;
    self.titleLabel=titleLabel;
}
-(void)createLeftBtn
{
    UIButton* leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0,0,40,40)];
    [leftBtn    setTitle:@"设置" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.settingBtn=leftBtn;
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:self.settingBtn];
    
    self.navigationItem.leftBarButtonItem=leftItem;
}
-(void)createRightBtn
{
    UIButton* rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(0,0,40,40)];
    [rightBtn setTitle:@"好友" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.goodFriendBtn=rightBtn;
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:self.goodFriendBtn];
    self.navigationItem.rightBarButtonItem=rightItem;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.plistDataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellID=@"cell";
    mySpaceCell* cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"mySpaceCell" owner:nil options:nil] lastObject];
    }
    NSDictionary* dict=self.plistDataArray[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.icon.image=[UIImage imageNamed:dict[@"icon"]];
    cell.visitorFriendIcon.image=[UIImage imageNamed:dict[@"visitorFriendIcon"]];
    cell.visitorLabel.text=dict[@"visitorLabel"];
    cell.friendName.text=dict[@"friendName"];
    return cell;
}

#pragma mark - 设置按钮响应方法
-(void)leftBtnAction
{
    NSLog(@"点击了左边的设置按钮");
    settingViewController* settingVc=[[settingViewController alloc]init];
    //self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:settingVc animated:YES];
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
    //self.titleLabel.alpha=alpha;
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
    if (indexPath.row==self.plistDataArray.count-3) {
        qqBackgroundMusicViewController* bgMusic=[[qqBackgroundMusicViewController alloc]init];
        [self.navigationController pushViewController:bgMusic animated:YES];
    }
    else if (indexPath.row==self.plistDataArray.count-2)
    {
        loverViewController* loveVc=[[loverViewController alloc]init];
        [self.navigationController pushViewController:loveVc animated:YES];
    }
    
}

@end
