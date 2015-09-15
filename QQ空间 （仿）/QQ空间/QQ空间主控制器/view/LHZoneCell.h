//
//  LHZoneCell.h
//  QQ空间
//
//  Created by 妖精的尾巴 on 15-8-31.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHZoneCell : UITableViewCell
/**
 *qq好友头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
/**
 *qq好友昵称
 */
@property (weak, nonatomic) IBOutlet UILabel *usernickName;
/**
 *qq好友消息发布时间
 */
@property (weak, nonatomic) IBOutlet UILabel *userPubulishTime;
/**
 *qq好友消息内容
 */
@property (weak, nonatomic) IBOutlet UILabel *userContentLabel;
/**
 *qq好友浏览下面icon
 */
@property (weak, nonatomic) IBOutlet UIImageView *userbrowseIcon;
/**
 *qq好友本条说说的次数
 */
@property (weak, nonatomic) IBOutlet UILabel *userbrowseLabel;
/**
 *qq好友消息转发本条说说按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *userRepostBtn;
/**
 *qq好友点赞本条说说按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *userAppreciateBtn;
/**
 *qq好友评论本条说说
 */
@property (weak, nonatomic) IBOutlet UIButton *userCommentBtn;
/**
 *好友发消息的配图imageView
 */
@property (weak, nonatomic) IBOutlet UIImageView *userContentImage;
/**
 *好友手机类型
 */
@property (weak, nonatomic) IBOutlet UILabel *userPhoneSource;
/**
 *好友消息点赞数
 */
@property (weak, nonatomic) IBOutlet UILabel *userAppreciateNumbers;

@end
