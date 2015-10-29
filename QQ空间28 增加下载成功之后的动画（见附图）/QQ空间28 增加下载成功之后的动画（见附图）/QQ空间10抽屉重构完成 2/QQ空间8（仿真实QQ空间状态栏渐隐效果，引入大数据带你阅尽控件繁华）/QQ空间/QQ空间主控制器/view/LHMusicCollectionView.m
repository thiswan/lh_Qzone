//
//  LHMusicCollectionView.m
//  QQ空间
//
//  Created by 妖精的尾巴 on 15-9-21.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import "LHMusicCollectionView.h"
#import "LHMusicCollectionCell.h"

#define kScreenWidth  100
#define kScreenHeight  160

@interface LHMusicCollectionView()<NSURLSessionDownloadDelegate>
/**
 *下载任务
 */
@property(nonatomic,strong)NSURLSessionDownloadTask* task;
/**
 *记录上次暂停下载返回的记录
 */
@property(nonatomic,strong)NSData* resumeData;
/**
 *创建下载任务的属性
 */
@property(nonatomic,strong)NSURLSession* session;
/**
 *记录索引
 */
@property(nonatomic,assign)NSInteger index;

@end

@implementation LHMusicCollectionView

static NSString* cellID=@"musicCell";

-(id)initWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout* flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    flowLayout.itemSize=CGSizeMake(kScreenWidth, kScreenHeight);
    flowLayout.minimumLineSpacing=10;
    self=[super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        self.backgroundColor=[UIColor lightGrayColor];
        self.dataSource=self;
        self.delegate=self;
       
        [self registerNib:[UINib nibWithNibName:@"LHMusicCollectionCell" bundle:[NSBundle   mainBundle]] forCellWithReuseIdentifier:cellID];
    }
    return self;
}
#pragma mark - 懒加载
-(NSURLSession*)session
{
    if (!_session)
    {
        NSURLSessionConfiguration* configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
        self.session=[NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    };
    return _session;
}
#pragma mark - UICollectionViewDataSource方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.plistDataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LHMusicCollectionCell* cell=[collectionView  dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"LHMusicCollectionCell" owner:self options:nil] lastObject];
    }
    NSDictionary* dict=self.plistDataArray[indexPath.item];
    cell.MusicImage.image=[UIImage imageNamed:dict[@"image"]];
    cell.MusicTitle.text=dict[@"title"];
    cell.MusicSinger.text=dict[@"singer"];
    cell.url=dict[@"url"];
    return cell;
}
#pragma mark - UICollectionViewDelegate方法

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell被点击%ld",(long)indexPath.item);
    self.index=indexPath.item;
    
    if (self.task==nil)
    {
        if (self.resumeData)
        {
            [self resume];
            NSLog(@"继续下载");
        }
        else
        {
            [self start];
            NSLog(@"开始下载");
        }
    }
    else
    {
        [self pause];
    }
}
#pragma mark -
/**
 *开始下载任务
 */
-(void)start
{
    /**
     *开始下载的两个步骤
     */
    //1-----创建下载任务（该URL为历趣网下载百度地图的URL）
//    NSURL* url=[NSURL URLWithString:@"http://filelx.liqucn.com/upload/2011/gps/baidumap_AndroidPhone_v8.3.0_8.3.0.1_1006817j.ptada"];
    //此下载链接为百度音乐（城里的月光-许美静）的下载链接
    //    NSURL* url=[NSURL URLWithString:@"http://yinyueshiting.baidu.com/data2/music/124483073/20969210080064.mp3?xcode=c98f643cbbd1864c86c86b4d2d72cc37"];
    NSDictionary* dict=self.plistDataArray[self.index];
    NSURL* url=[NSURL   URLWithString:dict[@"url"]];
    self.task=[self.session downloadTaskWithURL:url];
    //2-----开始下载任务
    [self.task resume];
}
/**
 *继续下载任务
 */
-(void)resume
{
    /**
     *继续下载的三个步骤
     */
    [self.session downloadTaskWithResumeData:self.resumeData];
    [self resume];
    self.resumeData=nil;
}
/**
 *暂停下载任务
 */
-(void)pause
{
    /**
     *强引用嵌套，将self进行弱引用
     */
    NSLog(@"暂停下载");
    __weak typeof(self) vc=self;
    [self.task cancelByProducingResumeData:^(NSData *resumeData) {
        vc.resumeData=resumeData;
        vc.task=nil;
    }];
}
#pragma mark-------NSURLSessionDownloadDelegate代理方法
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    /**
     *消息背景控件label
     */
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(0, -40, self.bounds.size.width, 40)];
    label.backgroundColor=[UIColor orangeColor];
    label.text=@"歌曲下载成功";
    label.textAlignment=1;
    label.font=[UIFont systemFontOfSize:15];
    [self addSubview:label];
    /**
     *下载成功显示动画
     */
    [UIView animateWithDuration:2 animations:^{
        label.frame=CGRectMake(0, 0, self.bounds.size.width, 40);
    } completion:^(BOOL finished)
     {
         [UIView animateWithDuration:2.0 delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
            label.frame=CGRectMake(0, -40, self.bounds.size.width, 40);
         } completion:^(BOOL finished) {
             [label removeFromSuperview];
         }];
         
     }];

    //1----拿到caches文件夹的路径
    NSString* caches=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //2----拿到caches文件夹和文件名
    NSString* file=[caches stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    NSFileManager* manager=[NSFileManager  defaultManager];
    //3----移动下载好的文件到指定的文件夹
    [manager moveItemAtPath:location.path toPath:file error:nil];
}
/**
 *Sent periodically to notify the delegate of download progress.
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    NSLog(@"正在下载中。。。。");
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes
{
    NSLog(@"调用了这个方法");
}
@end
