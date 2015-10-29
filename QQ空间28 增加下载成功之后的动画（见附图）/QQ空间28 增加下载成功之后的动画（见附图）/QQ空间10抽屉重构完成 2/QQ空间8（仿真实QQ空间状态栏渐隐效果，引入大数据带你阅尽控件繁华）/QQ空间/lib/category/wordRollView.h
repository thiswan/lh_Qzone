//
//  wordRollView.h
//  QQ空间
//
//  Created by 妖精的尾巴 on 15-9-15.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface wordRollView : UIView
/**
 *初始化方法,指定view的frame，title,titleColor
 */
-(instancetype)initWithFrame:(CGRect)frame title:(NSString*)title TextColor:(UIColor*)color;

/**
 *开始滚动动画
 */
-(void)startRollAnimation;

/**
 *停止滚动动画
 */
-(void)stoprollAnimation;
@end
