//
//  LHFlowingPhotoView.m
//  QQ空间
//
//  Created by 妖精的尾巴 on 15-9-17.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import "LHFlowingPhotoView.h"
#import "UIView+Extesion.h"
#import <Social/Social.h>

#define timeInterval 0.5
#define scaleFactor  0.5
#define Radius  2

@interface LHBackgroundView()
/**
 *图片当前缩放比
 */
@property(nonatomic,assign)float currentScale;
/**
 *用来接受点击当前图片的属性
 */
@property(nonatomic,strong)UIImage* srcImage;

@end

@implementation LHFlowingPhotoView

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.layer.borderWidth=Radius;
        self.layer.borderColor=[[UIColor redColor] CGColor];
        
        [self setupSubviews];
        [self startTimer];
        [self addGestureToView];
    }
    return self;
}
-(void)setupSubviews
{
    self.imageView=[[UIImageView alloc]initWithFrame:self.bounds];
    self.imageView.backgroundColor=[UIColor blueColor];
    self.imageView.contentMode=UIViewContentModeScaleAspectFit;
    
    self.backgroundView=[[LHBackgroundView alloc]initWithFrame:self.bounds];
    self.backgroundView.contentMode=UIViewContentModeScaleAspectFit;
    
    [self addSubview:self.backgroundView];
    [self addSubview:self.imageView];
}
-(void)startTimer
{
    self.timer=[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(movingPictures) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:@"NSDefaultRunLoopMode"];
}
-(void)movingPictures
{
    self.center=CGPointMake(self.center.x+self.currentSpeed, self.center.y);
    if (self.center.x>self.superview.width+self.width*scaleFactor) {
        self.center=CGPointMake(-self.width*scaleFactor, arc4random()%(int)((self.superview.height-self.height)+self.height*scaleFactor));
    }
}
-(void)addGestureToView
{
    UITapGestureRecognizer* tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap)];
    [self addGestureRecognizer:tapGesture];
    
    UISwipeGestureRecognizer* swipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(imageSwipe)];
    [swipeGesture setDirection:UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight];
    [self addGestureRecognizer:swipeGesture];
    
    UIPinchGestureRecognizer* pinchGesture=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(imagePinch:)];
    [self addGestureRecognizer:pinchGesture];
    
    UIRotationGestureRecognizer* ratationGesture=[[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(imageRotation:)];
    [self addGestureRecognizer:ratationGesture];
    
   
    
}
-(void)imageTap
{
    [UIView animateWithDuration:timeInterval animations:^{
        if (self.currentState==LHPhotoStateNormal) {
            self.primaryFrame=self.frame;
            self.primaryAlpha=self.alpha;
            self.primarySpeed=self.currentSpeed;
            self.frame=CGRectMake(navgationBarHeight-40,navgationBarHeight, self.superview.width-50, self.superview.height-80);
            self.backgroundView.frame=self.bounds;
            self.imageView.frame=self.bounds;
            [self.superview bringSubviewToFront:self];
            self.currentSpeed=0.0f;
            self.alpha=1.0f;
            self.currentState=LHPhotoStateLarge;
        }
        else if (self.currentState==LHPhotoStateLarge)
        {
            self.frame=self.primaryFrame;
            self.alpha=self.primaryAlpha;
            self.currentSpeed=self.primarySpeed;
            self.backgroundView.frame=self.bounds;
            self.imageView.frame=self.bounds;
            self.currentState=LHPhotoStateNormal;
        }
    }];
}
-(void)imageSwipe
{
    
    if (self.currentState == LHPhotoStateLarge) {
        [self exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
        self.currentState = LHPhotoStateBackground;
    } else if (self.currentState == LHPhotoStateBackground){
        [self exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
        self.currentState = LHPhotoStateLarge;
    }
}
-(void)imagePinch:(UIPinchGestureRecognizer*)gesture
{
    if (self.currentState==LHPhotoStateBackground | self.currentState==LHPhotoStateNormal | self.currentState==LHPhotoStateParalleling) {
        return;
    }
    else{
        if (gesture.state==UIGestureRecognizerStateBegan) {
            self.imageView.transform=CGAffineTransformMakeScale(1.2, 1.2);
            NSLog(@"捏合手势开始");
        }
        else if (gesture.state==UIGestureRecognizerStateEnded)
        {
            self.imageView.transform=CGAffineTransformIdentity;
            NSLog(@"捏合手势结束");
        }
    }
    
}
-(void)imageRotation:(UIRotationGestureRecognizer* )gesture
{
    NSLog(@"捏合手势");
}
/**
 *切换图片的方法
 */
- (void)lh_changeOverImage:(UIImage *)image
{
    self.imageView.image = image;
}
/**
 *设置图片的alpha，speed的方法
 */
- (void)lh_setImageAlphaAndSpeedAndSize:(float)alpha
{
    self.alpha = alpha;
    self.currentSpeed = alpha;
    self.transform = CGAffineTransformScale(self.transform, alpha, alpha);
}
@end
