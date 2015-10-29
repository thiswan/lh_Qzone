//
//  yeardayViewController.m
//  QQ空间
//
//  Created by 妖精的尾巴 on 15-9-17.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import "yeardayViewController.h"
#import "UIBarButtonItem+Extesion.h"
#import "LHFlowingPhotoView.h"
#import "UIView+Extesion.h"
#import <Social/Social.h>

#define imageWidth 100
#define imageHeight 120

@interface yeardayViewController()
/**
 *存放图片的数组
 */
@property(nonatomic,strong)NSMutableArray* photoArray;
/**
 *流动相册
 */
@property(nonatomic,strong)LHFlowingPhotoView* FlowingView;
/**
 *用于滚动的scrollView
 */
@property(nonatomic,strong)UIScrollView* scrollView;

@end

@implementation yeardayViewController

-(NSMutableArray*)photoArray
{
    if (_photoArray==nil) {
        _photoArray=[NSMutableArray array];
    }
    return _photoArray;
}
-(UIScrollView*)scrollView
{
    if (_scrollView==nil) {
        _scrollView=[[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _scrollView.contentSize=CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height*4);
        _scrollView.backgroundColor=[UIColor greenColor];
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor lightGrayColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.navigationItem.title=@"照片墙";
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem  initWithTitle:@"返回" titleColor:[UIColor blackColor] target:self action:@selector(back)];
   [self addPicturesToView];
    
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTapAction)];
    [doubleTap setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubleTap];
    
    UILongPressGestureRecognizer  *longGesture=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(imageLongPress:)];
    [self.view addGestureRecognizer:longGesture];

  }
- (void)doubleTapAction
{
    for (LHFlowingPhotoView *photo in self.photoArray) {
        if (photo.currentState == LHPhotoStateBackground || photo.currentState == LHPhotoStateLarge) {
            return;
        }
    }
    
    float W = self.view.bounds.size.width / 3;
    float H = self.view.bounds.size.height / 3;
    
    [UIView animateWithDuration:1 animations:^{
        for (int i = 0; i < self.photoArray.count; i++) {
            LHFlowingPhotoView *photo = [self.photoArray objectAtIndex:i];
            if (photo.currentState ==LHPhotoStateNormal) {
                photo.primaryAlpha = photo.alpha;
                photo.primaryFrame = photo.frame;
                photo.primarySpeed = photo.currentSpeed;
                photo.alpha = 1;
                photo.frame = CGRectMake(i%3*W, i/3*H+navgationBarHeight, W, H);
                photo.imageView.frame = photo.bounds;
                photo.backgroundView.frame = photo.bounds;
                photo.currentSpeed = 0;
                photo.currentState = LHPhotoStateParalleling;
            } else if (photo.currentState == LHPhotoStateParalleling) {
                photo.alpha = photo.primaryAlpha;
                photo.frame = photo.primaryFrame;
                photo.currentSpeed = photo.primarySpeed;
                
                photo.imageView.frame = photo.bounds;
                photo.backgroundView.frame = photo.bounds;
                photo.currentState = LHPhotoStateNormal;
            }
        }
        
    }];
    
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:^{
        self.FlowingView.timer=nil;
        NSLog(@"%@",self.FlowingView.timer);
    }];
}
-(void)addPicturesToView
{
    NSFileManager* fileManager=[NSFileManager defaultManager];
    NSMutableArray *photoPaths = [[NSMutableArray alloc]init];
    NSString* bundelPath=[[NSBundle mainBundle] bundlePath];
      if ([fileManager fileExistsAtPath:bundelPath]) {
          NSArray* fileContentArray=[fileManager contentsOfDirectoryAtPath:bundelPath error:nil];
          for (NSString* fileName in fileContentArray) {
              if ([fileName hasSuffix:@"jpg"] ) {
                  NSString* photoPath=[bundelPath   stringByAppendingPathComponent:fileName];
                  [photoPaths addObject:photoPath];
              }
          }
      }
      if (photoPaths) {
          for (int i=0; i<9; i++) {
              
              float X = arc4random()%((int)self.view.bounds.size.width - imageWidth + navgationBarHeight);
              float Y = arc4random()%((int)self.view.bounds.size.height - imageHeight + navgationBarHeight);
              float W=imageWidth;
              float H=imageHeight;
              
              self.FlowingView=[[LHFlowingPhotoView alloc]initWithFrame:CGRectMake(X, Y, W, H)];
              [self.FlowingView lh_changeOverImage:[UIImage imageWithContentsOfFile:photoPaths[i]]];
              [self.scrollView addSubview:self.FlowingView];
              float alpha=i*1.0/10+0.2;
              [self.FlowingView lh_setImageAlphaAndSpeedAndSize:alpha];
              
              [self.photoArray addObject:self.FlowingView];
          }
      }
}
-(void)imageLongPress:(UILongPressGestureRecognizer*)gesture
{
   

    if (self.FlowingView.currentState==LHPhotoStateLarge)
    {
        if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo])
        {
            UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"亲，你还没有登录哦" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
        SLComposeViewController *cvv = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
        [cvv setInitialText:@"妖精的尾巴分享了图片，你也来看看吧，说不定有惊喜哦。"];
        NSURL* url=[NSURL URLWithString:@"http://my.oschina.net/iOSliuhui/blog"];
        [cvv addURL:url];
        [self presentViewController:cvv animated:YES completion:nil];
        cvv.completionHandler = ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultCancelled) {
                NSLog(@"取消发送");
            } else {
                NSLog(@"发送完毕");
            }
        };
    }
    else
    {
        NSLog(@"什么也不做，直接返回");
        return;
    }
}
@end
