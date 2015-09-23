//
//  WCContactCell.h
//  WeChat
//
//  Created by 宋红亮 on 15/8/29.
//  Copyright © 2015年 Song. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCContactCell : UITableViewCell

/** XMPP中的好友模型 */
@property (nonatomic, strong) XMPPUserCoreDataStorageObject *frd;

@end
