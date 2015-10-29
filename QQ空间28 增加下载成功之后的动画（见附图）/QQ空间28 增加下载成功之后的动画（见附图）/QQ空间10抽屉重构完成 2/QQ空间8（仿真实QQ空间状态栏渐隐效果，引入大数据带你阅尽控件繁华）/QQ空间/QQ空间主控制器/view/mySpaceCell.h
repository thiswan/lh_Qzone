//
//  mySpaceCell.h
//  QQ空间
//
//  Created by 妖精的尾巴 on 15-9-2.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mySpaceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *visitorLabel;
@property (weak, nonatomic) IBOutlet UIImageView *visitorFriendIcon;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *friendName;

@end
