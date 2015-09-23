//
//  WCXMPPTool.h
//  WeChat
//
//  Created by 宋红亮 on 15/8/23.
//  Copyright © 2015年 Song. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "XMPPFramework.h"
#import "XMPPMessageArchivingCoreDataStorage.h"
typedef enum {
    XMPPResultTypeLoginSuccess,
    XMPPResultTypeLoginFailure,
    XMPPResultTypeNetError,
}XMPPResultType;

/** XMPP的请求结果 */
typedef void (^XMPPResultBlock)(XMPPResultType type);


@interface WCXMPPTool : NSObject

singleton_interface(WCXMPPTool)


@property (nonatomic, strong) XMPPStream *xmppStream;
/** 名片\个人资料 */
@property (nonatomic, strong) XMPPvCardTempModule *vCard;
/** 花名册\好友 */
@property (nonatomic, strong) XMPPRoster *roster;
/** 花名册\好友 存储 */
@property (nonatomic, strong) XMPPRosterCoreDataStorage *rosterStorage;
/** 是否是注册 `YES`注册 `NO`登录 */
@property (nonatomic, assign, getter=isRegisterOperation) BOOL registerOperation;
/**信息 */
@property(nonatomic,strong) XMPPMessage* receiveMessage;
/**信息存储 */
@property (nonatomic, strong) XMPPMessageArchivingCoreDataStorage *xmppMessageArchivingCoreDataStorage;
@property (nonatomic, strong) XMPPMessageArchiving *xmppMessageArchivingModule;

/** 登录 */
- (void)xmppLogin:(XMPPResultBlock)resultBlock;
/** 注销 */
- (void)xmppLogout;

@end
