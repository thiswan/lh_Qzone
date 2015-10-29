//
//  LHMusicCollectionCell.h
//  QQ空间
//
//  Created by 妖精的尾巴 on 15-9-21.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHMusicCollectionCell : UICollectionViewCell
/**
 *歌曲海报
 */
@property (weak, nonatomic) IBOutlet UIImageView *MusicImage;
/**
 *歌曲标题
 */
@property (weak, nonatomic) IBOutlet UILabel *MusicTitle;
/**
 *歌曲歌手
 */
@property (weak, nonatomic) IBOutlet UILabel *MusicSinger;
/**
 *歌曲的URL地址
 */
@property(nonatomic,copy)NSString* url;

@end
