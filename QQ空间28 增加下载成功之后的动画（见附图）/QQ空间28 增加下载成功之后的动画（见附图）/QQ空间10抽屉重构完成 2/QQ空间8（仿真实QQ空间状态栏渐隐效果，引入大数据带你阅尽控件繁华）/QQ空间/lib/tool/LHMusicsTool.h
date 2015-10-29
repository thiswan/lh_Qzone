//
//  LHMusicsTool.h
//  简单封装音乐播放
//
//  Created by 妖精的尾巴 on 15-8-18.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface LHMusicsTool : NSObject


/**
 *播放音乐
 *
 *name 音乐文件名
 */
+(BOOL)playMusic:(NSString*)name;
/**
 *暂停音乐
 *
 *name 音乐文件名
 */
+(void)pauseMusic:(NSString*)name;
/**
 *停止音乐
 *
 *name 音乐文件名
 */
+(void)stopMusic:(NSString*)name;
@end
