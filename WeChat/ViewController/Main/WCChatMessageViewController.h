//
//  WCChatMessageViewController.h
//  WeChat
//
//  Created by 宋红亮 on 15/9/15.
//  Copyright © 2015年 Song. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPP.h"
#import "XMPPMessageArchiving_Message_CoreDataObject.h"
#import "XMPPUserCoreDataStorageObject.h"
@interface WCChatMessageViewController : UITableViewController
@property(nonatomic,strong) XMPPUserCoreDataStorageObject* friend;
@end
