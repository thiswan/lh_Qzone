//
//  LHFlowingPhotoView.h
//  QQ空间
//
//  Created by 妖精的尾巴 on 15-9-17.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHBackgroundView.h"

typedef NS_ENUM(NSInteger, LHPhotoState){
    LHPhotoStateNormal,
    LHPhotoStateLarge,
    LHPhotoStateBackground,
    LHPhotoStateParalleling
};

@interface LHFlowingPhotoView : UIView
/**
 *原始透明度
 */
@property(nonatomic,assign)float primaryAlpha;
/**
 *原始速度
 */
@property(nonatomic,assign)float primarySpeed;
/**
 *当前速度
 */
@property(nonatomic,assign)float currentSpeed;
/**
 *原始frame
 */
@property(nonatomic,assign)CGRect primaryFrame;
/**
 *当前状态
 */
@property(nonatomic,assign)NSInteger currentState;
/**
 *显示图片的imageView
 */
@property(nonatomic,strong)UIImageView* imageView;
/**
 *显示背景的backgroundView
 */
@property(nonatomic,strong)LHBackgroundView* backgroundView;
/**
 *定时器
 */
@property(nonatomic,strong)NSTimer* timer;
/**
 *切换图片的方法
 */
- (void)lh_changeOverImage:(UIImage *)image;
/**
 *设置图片的alpha，speed的方法
 */
- (void)lh_setImageAlphaAndSpeedAndSize:(float)alpha;

@end
