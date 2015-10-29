//
//  qqBackgroundMusicViewController.m
//  QQ空间
//
//  Created by 妖精的尾巴 on 15-9-4.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import "qqBackgroundMusicViewController.h"

@interface qqBackgroundMusicViewController ()<NSURLSessionDownloadDelegate,UIAlertViewDelegate>
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

@end

@implementation qqBackgroundMusicViewController
-(NSURLSession*)session
{
    if (!_session)
    {
        NSURLSessionConfiguration* configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
        self.session=[NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    };
    return _session;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"背景音乐";
    self.view.backgroundColor=[UIColor greenColor];
    
}
- (IBAction)downloadMusic:(id)sender {
    
    if (self.task==nil)
    {
        if (self.resumeData)
        {
            [self resume];
            [self.downloadBtn setTitle:@"继续下载中" forState:UIControlStateNormal];
        }
        else
        {
            [self start];
            [self.downloadBtn setTitle:@"正在下载，请稍等" forState:UIControlStateNormal];
        }
    }
    else
    {
        [self pause];
        [self.downloadBtn setTitle:@"已暂停下载" forState:UIControlStateNormal];
    }
}
/**
 *开始下载任务
 */
-(void)start
{
    /**
     *开始下载的两个步骤
     */
    //1-----创建下载任务（该URL为历趣网下载百度地图的URL）
        NSURL* url=[NSURL URLWithString:@"http://filelx.liqucn.com/upload/2011/gps/baidumap_AndroidPhone_v8.3.0_8.3.0.1_1006817j.ptada"];
//此下载链接为百度音乐（城里的月光-许美静）的下载链接
//    NSURL* url=[NSURL URLWithString:@"http://yinyueshiting.baidu.com/data2/music/124483073/20969210080064.mp3?xcode=c98f643cbbd1864c86c86b4d2d72cc37"];
   
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
    UIAlertView* alter=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"亲，你的音乐下载好了，快去听听吧" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"知道了", nil];
    [alter show];
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
    self.progressView.progress=(double)totalBytesWritten/totalBytesExpectedToWrite;
    NSString* text=[NSString stringWithFormat:@"当前下载进度: %f",self.progressView.progress];
    self.progressLabel.text=text;
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes
{
    NSLog(@"调用了这个方法");
}
#pragma mark------
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        self.progressView.progress=0.0f;
        self.progressLabel.text=@"当前没有下载任务";
        [self.downloadBtn setTitle:@"下载完成" forState:UIControlStateNormal];
    }
}
@end
