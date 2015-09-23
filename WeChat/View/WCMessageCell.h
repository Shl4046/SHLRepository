//
//  WCMessageCellTableViewCell.h
//  WeChat
//
//  Created by 宋红亮 on 15/9/16.
//  Copyright © 2015年 Song. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPPMessage.h"
#import "XMPPMessageArchiving_Message_CoreDataObject.h"
@interface WCMessageCell : UITableViewCell
@property(nonatomic,strong) XMPPMessageArchiving_Message_CoreDataObject* messagedata;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end
