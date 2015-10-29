//
//  LHMusicsTool.m
//  简单封装音乐播放
//
//  Created by 妖精的尾巴 on 15-8-18.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import "LHMusicsTool.h"

@implementation LHMusicsTool
/**
 *存放本地所有音乐文件
 */
static NSMutableDictionary* _musics;

+(NSMutableDictionary *)musics
{
    if (!_musics) {
        _musics=[NSMutableDictionary dictionary];
    }
    return _musics;
}

/**
 *播放音乐
 *
 *name 音乐文件名
 */
+(BOOL)playMusic:(NSString*)name
{
    /**
     *1-----判断文件名是否存在
     */
    if (!name)
    {
        return  NO;
    }
    /**
     *2-----根据对应的文件名取对应的播放器
     */
    AVAudioPlayer* player=[self musics][name];
    
    if (!player) {
        NSURL* url=[[NSBundle mainBundle]URLForResource:name withExtension:nil];
        if (!url)
        {
            return NO;
        }
        player=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    /**
     *3-----缓冲
     */
        if (![player prepareToPlay])
        {
            return NO;
        }
    /**
     *4-----存入字典
     */
            [self musics][name]=player;
        }
    if (!player.isPlaying) {
        return [player play];
    }
    return YES;
}
/**
 *暂停音乐
 *
 *name 音乐文件名
 */
+(void)pauseMusic:(NSString*)name
{
    /**
     *1-----判断文件名是否存在
     */
    if (!name)
    {
        return;
    }
    
    /**
     *2-----根据对应的文件名取对应的播放器
     */
    AVAudioPlayer* player=[self musics][name];
    
    /**
     *3-----暂停
     */
    if (player.isPlaying) {
        [player pause];
    }
}
/**
 *停止音乐
 *
 *name 音乐文件名
 */
+(void)stopMusic:(NSString*)name
{
    /**
     *1-----判断文件名是否存在
     */
    if (!name)
    {
        return;
    }
    
    /**
     *2-----根据对应的文件名取对应的播放器
     */
    AVAudioPlayer* player=[self musics][name];
    
    /**
     *3------停止
     */
    [player stop];
    
    
    /**
     *4------从字典中移除播放器
     */
    [[self musics] removeObjectForKey:name];
}

@end
