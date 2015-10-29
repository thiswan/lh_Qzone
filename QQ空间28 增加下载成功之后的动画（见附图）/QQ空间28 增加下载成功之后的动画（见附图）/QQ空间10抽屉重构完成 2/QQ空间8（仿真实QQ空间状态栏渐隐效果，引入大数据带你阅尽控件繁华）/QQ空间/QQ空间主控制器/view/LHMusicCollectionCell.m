//
//  LHMusicCollectionCell.m
//  QQ空间
//
//  Created by 妖精的尾巴 on 15-9-21.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import "LHMusicCollectionCell.h"

@implementation LHMusicCollectionCell

- (void)awakeFromNib {
    self.MusicImage.layer.borderColor=[[UIColor greenColor] CGColor];
    self.MusicImage.layer.borderWidth=1.0f;
    self.MusicImage.layer.cornerRadius=4;
    self.MusicImage.clipsToBounds=YES;
    
}

@end
