//
//  wordRollView.m
//  QQ空间
//
//  Created by 妖精的尾巴 on 15-9-15.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import "wordRollView.h"
#import "UIView+Extesion.h"

#define textFont 16

@interface wordRollView()

/**
 *该属性用于记录label的起始位置
 */
@property(nonatomic,assign)CGRect sourceRect;
/**
 *该属性用于记录label的移动后的位置
 */
@property(nonatomic,assign)CGRect nextRect;
/**
 *该属性用于两个位置的交换的数组
 */
@property(nonatomic,strong)NSMutableArray* labelArray;
/**
 *该属性用来记录的文字滚动的时间
 */
@property(nonatomic,assign)CGFloat time;
/**
 *该属性用来记录LED动画是否滚动
 */
@property(nonatomic,assign)BOOL isStop;

@end


@implementation wordRollView

-(NSMutableArray*)labelArray
{
    if (_labelArray==nil) {
        _labelArray=[NSMutableArray array];
    }
    return _labelArray;
}

/**
 *初始化方法,指定view的frame，title,titleColor
 */
-(instancetype)initWithFrame:(CGRect)frame title:(NSString*)title TextColor:(UIColor*)color
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=[UIColor clearColor];
        self.clipsToBounds=YES;
        /**
         *第一步 创建并初始化label
         */
        UILabel* contentLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        title=[NSString stringWithFormat:@"         %@        ",title];
        _time=[self displayDurationForString:title];
        contentLabel.text=title;
        contentLabel.textColor=color;
        contentLabel.font=[UIFont boldSystemFontOfSize:textFont];
        CGSize sourceSize=[contentLabel sizeThatFits:CGSizeZero];
        
        self.sourceRect = CGRectMake(0, 0, sourceSize.width, self.bounds.size.height);
        self.nextRect= CGRectMake(self.sourceRect.origin.x+self.sourceRect.size.width, 0, sourceSize.width, self.bounds.size.height);
        
        contentLabel.frame=self.sourceRect;
        [self addSubview:contentLabel];
        
        /**
         *第二步 加入数组
         */
        [self.labelArray addObject:contentLabel];
        
        /**
         *第三步 当前label的宽度是否大于屏幕宽度
         */
        BOOL isAnimate = sourceSize.width>frame.size.width?YES:NO;
        if (isAnimate) {
            UILabel* nextLabel = [[UILabel alloc] initWithFrame:self.nextRect];
            nextLabel.textColor = color;
            nextLabel.font = [UIFont boldSystemFontOfSize:textFont];
            nextLabel.text = title;
            [self addSubview:nextLabel];
            
            [self.labelArray addObject:nextLabel];
            
            [self LEDAnimate];
        }
    }
    return self;
}
/**
 *执行LED电子屏幕滚动效果
 */
-(void)LEDAnimate
{
    if (!_isStop) {
        UILabel* lbindex0 = _labelArray[0];
        UILabel* lbindex1 = _labelArray[1];
        
        [UIView transitionWithView:self duration:_time options:UIViewAnimationOptionCurveLinear animations:^{
        
            lbindex0.frame = CGRectMake(-self.sourceRect.size.width, 0, self.sourceRect.size.width, self.sourceRect.size.height);
            lbindex1.frame = CGRectMake(lbindex0.frame.origin.x+lbindex0.frame.size.width, 0, lbindex1.frame.size.width, lbindex1.frame.size.height);
            
        } completion:^(BOOL finished) {
            
            lbindex0.frame = self.nextRect;
            lbindex1.frame = self.sourceRect;
            
            [_labelArray replaceObjectAtIndex:0 withObject:lbindex1];
            [_labelArray replaceObjectAtIndex:1 withObject:lbindex0];
            
            [self LEDAnimate];
        }];
    }

}

/**
 *开始滚动动画
 */
-(void)startRollAnimation
{
    _isStop = NO;
    UILabel* lbindex0 = _labelArray[0];
    UILabel* lbindex1 = _labelArray[1];
    lbindex0.frame = _nextRect;
    lbindex1.frame = _sourceRect;
    
    [_labelArray replaceObjectAtIndex:0 withObject:lbindex1];
    [_labelArray replaceObjectAtIndex:1 withObject:lbindex0];
    
    [self LEDAnimate];
}

/**
 *停止滚动动画
 */
-(void)stoprollAnimation
{
    _isStop=YES;
    NSLog(@"用户停止了LED动画效果");
}
/**
 *根据文字长度显示动画时长
 */
- (CGFloat)displayDurationForString:(NSString*)string {
    
    return string.length/3.0;
    //return MIN((float)string.length*0.1 + 0.5, 5.0);
}


@end
