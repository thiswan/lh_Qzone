//
//  leftDrawerView.m
//  QQ空间
//
//  Created by 妖精的尾巴 on 15-9-1.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import "leftDrawerView.h"
#import "yeardayViewController.h"
#import "LHMusicsTool.h"

@interface leftDrawerView()

@property(nonatomic,strong)NSArray* dataArray;

@end

@implementation leftDrawerView


-(void)loadPlist
{
   NSLog(@"加载数据文件");
    UITableView* table=[[UITableView alloc]initWithFrame:CGRectMake(0, 180, 250, 300) style:UITableViewStylePlain];
    table.scrollEnabled=NO;
    table.separatorColor=[UIColor clearColor];
    table.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.leftDrawerTableView=table;
    [self addSubview:self.leftDrawerTableView];
    table.delegate=self;
    table.dataSource=self;
   NSString* filePath=[[NSBundle mainBundle]pathForResource:@"leftDrawer.plist" ofType:nil];
   self.dataArray=[NSArray arrayWithContentsOfFile:filePath];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"加载表格行数");
    return self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellID=@"cellId";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    NSDictionary* dict=self.dataArray[indexPath.row];
    cell.imageView.image=[UIImage imageNamed:dict[@"icon"]];
    cell.textLabel.text=dict[@"title"];
    return cell;
}
#warning 这里没有用自定义的表格
//-(void)awakeFromNib
//{
// [self loadPlist];
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

@end
