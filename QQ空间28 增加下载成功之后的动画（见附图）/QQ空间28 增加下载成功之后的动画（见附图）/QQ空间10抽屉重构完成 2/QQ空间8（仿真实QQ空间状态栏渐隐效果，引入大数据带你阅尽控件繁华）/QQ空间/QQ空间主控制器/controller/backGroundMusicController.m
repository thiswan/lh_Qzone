//
//  backGroundMusicController.m
//  QQ空间
//
//  Created by 妖精的尾巴 on 15-9-21.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import "backGroundMusicController.h"
#import "UIView+Extesion.h"
#import "LHMusicCollectionCell.h"
#import "LHMusicCollectionView.h"

#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight    [UIScreen mainScreen].bounds.size.height

@interface backGroundMusicController ()
/**
 *存储plist文件数组
 */
@property(nonatomic,strong)NSArray* plistDataArray;

@end

@implementation backGroundMusicController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"背景音乐";
    [self createLabel];
    [self loadPlistData];
    LHMusicCollectionView* collectionView=[[LHMusicCollectionView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-108)];
    collectionView.plistDataArray=self.plistDataArray;
    [self.view addSubview:collectionView];
}

-(void)loadPlistData
{
    NSString* pathFile=[[NSBundle mainBundle]pathForResource:@"backGroundMusic.plist" ofType:nil];
    self.plistDataArray=[NSArray arrayWithContentsOfFile:pathFile];
}
-(void)createLabel
{
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(40, 80, self.view.width-40*2, 40)];
    label.textColor=[UIColor whiteColor];
    label.font=[UIFont systemFontOfSize:16.0f];
    label.numberOfLines=0;
    label.adjustsFontSizeToFitWidth=YES;
    label.text=@"网页有y.qq.com提供\nQQ浏览器X5内核提供技术支持";
    [self.view addSubview:label];
}
@end
