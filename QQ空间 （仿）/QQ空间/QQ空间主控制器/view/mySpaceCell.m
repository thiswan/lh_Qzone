//
//  mySpaceCell.m
//  QQ空间
//
//  Created by 妖精的尾巴 on 15-9-2.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import "mySpaceCell.h"

@implementation mySpaceCell

- (void)awakeFromNib {
    // Initialization code
    self.visitorFriendIcon.layer.cornerRadius=20;
    self.visitorFriendIcon.layer.masksToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
