//
//  LHButton.m
//  QQ空间
//
//  Created by 妖精的尾巴 on 15-8-31.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import "LHButton.h"

@implementation LHButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGRect rect = CGRectMake(10, 5, 30, 30);
    return rect;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGRect rect = CGRectMake(45,5, 257, 30);
    return rect;
}
@end
