//
//  aboutMeCell.m
//  QQ空间
//
//  Created by 妖精的尾巴 on 15-9-1.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import "aboutMeCell.h"

@implementation aboutMeCell

- (void)awakeFromNib {
    NSLog(@"调用了awakeFromNib");
    NSLog(@"%@",NSStringFromCGRect(self.friendIcon.frame));
    self.friendIcon.layer.cornerRadius=25;
    self.friendIcon.layer.masksToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
