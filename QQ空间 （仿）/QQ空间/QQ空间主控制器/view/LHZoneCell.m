//
//  LHZoneCell.m
//  QQ空间
//
//  Created by 妖精的尾巴 on 15-8-31.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import "LHZoneCell.h"

@implementation LHZoneCell

- (void)awakeFromNib {
    self.userIcon.layer.cornerRadius = 25;
    self.userIcon.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
