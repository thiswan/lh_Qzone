//
//  MeViewController.m
//  QQ空间
//
//  Created by 妖精的尾巴 on 15-9-1.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import "MeViewController.h"
#import "aboutMeCell.h"
#import "UIBarButtonItem+Extesion.h"

@interface MeViewController ()<UITableViewDataSource,UITableViewDelegate>
/**
 *记录tableview的属性
 */
@property(nonatomic,weak)UITableView* table;
/**
 *存储plist文件的数组
 */
@property(nonatomic,strong)NSArray* dataArray;

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    [self loadPlist];
    self.table.rowHeight=168;
    self.tabBarItem.badgeValue=@"9";
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem itemWithTarget:self action:@selector(itemClick) image:@"nav_icon_r_refresh_disabled" highImage:@"nav_icon_r_refresh"];
   
}
-(void)itemClick
{
    UIAlertView* alter=[[UIAlertView alloc]initWithTitle:@"提示" message:@"该功能尚未开放" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alter show];
}
-(void)loadPlist
{
    NSString* filePath=[[NSBundle mainBundle]pathForResource:@"appreciate.plist" ofType:nil];
    self.dataArray=[NSArray arrayWithContentsOfFile:filePath];
}
-(void)createTableView
{
    UITableView* tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,-40, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    self.table=tableView;
    [self.view addSubview:self.table];
    tableView.delegate=self;
    tableView.dataSource=self;
}

#pragma mark - UITableViewDataSource 数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return  self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString* cellID=@"cell";
    aboutCell* cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"aboutCell" owner:nil options:nil]lastObject];
    }
    NSDictionary* dict =self.dataArray[indexPath.row];
    cell.friendIcon.image=[UIImage imageNamed:dict[@"friendIcon"]];
    cell.friendNickName.text=dict[@"friendNickName"];
    cell.appreciateTime.text=dict[@"appreciateTime"];
    return cell;
}

#pragma mark -UITableViewDelegate 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中的颜色
    //[LHMusicsTool playMusic:@"suc.wav"];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //[tableView endEditing:YES];
}

@end
