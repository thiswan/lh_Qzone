//
//  aboutQQViewController.m
//  QQ空间
//
//  Created by 妖精的尾巴 on 15-9-6.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import "aboutQQViewController.h"
#import "aboutQQCell.h"
#import "versionInfoViewController.h"
@interface aboutQQViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(weak,nonatomic)UITableView* tableView;
/**
 *存储plist文件数组
 */
@property(nonatomic,strong)NSArray* plistDataArray;
@end

@implementation aboutQQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor lightGrayColor];
    self.title=@"关于QQ空间";
    [self loadPlist];
    [self createTableView];
     self.tableView.rowHeight=40.0f;
}
-(void)loadPlist
{
    NSString* pathFile=[[NSBundle mainBundle]pathForResource:@"aboutQQ.plist" ofType:nil];
    self.plistDataArray=[NSArray arrayWithContentsOfFile:pathFile];
}
-(void)createTableView
{
    UITableView* tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, 200)];
    tableView.delegate=self;
    tableView.dataSource=self;
    self.tableView=tableView;
    [self.view addSubview:tableView];
}
#pragma mark - UITableViewDataSource代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.plistDataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellID=@"cell";
    aboutQQCell* cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"aboutQQCell" owner:nil options:nil] lastObject];
    }
    NSDictionary* dict=self.plistDataArray[indexPath.row];
    cell.aboutTitleLabel.text=dict[@"title"];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==self.plistDataArray.count-1) {
        versionInfoViewController* versionVc=[[versionInfoViewController alloc]init];
        [self.navigationController pushViewController:versionVc animated:YES];
    }
}


@end
