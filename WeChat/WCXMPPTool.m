//
//  WCXMPPTool.m
//  WeChat
//
//  Created by 宋红亮 on 15/8/23.
//  Copyright © 2015年 Song. All rights reserved.
//

#import "WCXMPPTool.h"
#import "XMPPMessage.h"


@interface WCXMPPTool () <XMPPStreamDelegate> {
    XMPPResultBlock _resultBlock;
    XMPPvCardCoreDataStorage *_vCardStorage;
    XMPPvCardAvatarModule *_vCardAvatar;
    XMPPReconnect *_reconnect;
}

- (void)setupXMPPStream;
- (void)connectToHost;
- (void)sendPwdToHost;
- (void)sendOnlineToHost;

@end

@implementation WCXMPPTool

singleton_implementation(WCXMPPTool)

#pragma mark 初始化XMPPStream
- (void)setupXMPPStream {
    
    _xmppStream = [[XMPPStream alloc] init];
    
    // 自动连接模块
    _reconnect = [[XMPPReconnect alloc] init];
    [_reconnect activate:_xmppStream];
    
    // 设置名片和头像
    _vCardStorage = [XMPPvCardCoreDataStorage sharedInstance];
    _vCard = [[XMPPvCardTempModule alloc] initWithvCardStorage:_vCardStorage];
    [_vCard activate:_xmppStream];
    
    // 花名册
    _rosterStorage = [XMPPRosterCoreDataStorage sharedInstance];
    _roster = [[XMPPRoster alloc] initWithRosterStorage:_rosterStorage];
    [_roster activate:_xmppStream];
    _xmppMessageArchivingCoreDataStorage = [XMPPMessageArchivingCoreDataStorage sharedInstance];
    _xmppMessageArchivingModule = [[XMPPMessageArchiving alloc]initWithMessageArchivingStorage:_xmppMessageArchivingCoreDataStorage];
    [_xmppMessageArchivingModule setClientSideMessageArchivingOnly:YES];
    [_xmppMessageArchivingModule activate:_xmppStream];
    [_xmppMessageArchivingModule addDelegate:self delegateQueue:dispatch_get_main_queue()];

    _vCardAvatar = [[XMPPvCardAvatarModule alloc] initWithvCardTempModule:_vCard];
    [_vCardAvatar activate:_xmppStream];
    
    [_xmppStream addDelegate:self
               delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
}

#pragma mark 移除XMPPStream
- (void)teardownXMPPStream {
    
    [_xmppStream removeDelegate:self];
    
    [_vCard deactivate];
    [_vCardAvatar deactivate];
    [_reconnect deactivate];
    [_roster deactivate];
    
    [_xmppStream disconnect];
    
    _vCard = nil;
    _vCardAvatar = nil;
    _vCardStorage = nil;
    _roster = nil;
    _rosterStorage = nil;
    _reconnect = nil;
    _xmppStream = nil;
}

#pragma mark 连接到服务器[传一个JID]
- (void)connectToHost {
    
    WCLog(@"开始连接服务器");
    
    if (!_xmppStream) {
        [self setupXMPPStream];
    }
    
    NSString *user = nil;
                                                      // 登录账号
    user = [WCUserInfo sharedWCUserInfo].user;
    
    
    // 用户JID
    XMPPJID *myJID = [XMPPJID jidWithUser:user domain:@"song-hongliang-macbook-pro.local" resource:@"iphone"];
    _xmppStream.myJID = myJID;
    _xmppStream.hostName = @"song-hongliang-macbook-pro.local";    // 域名
    _xmppStream.hostPort = 5222;                // 端口
    
    NSError *error = nil;
    [_xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error];
    if (error) {
        WCLog(@"%@", error);
    }
}


#pragma mark 连接到服务成功后，发送密码授权
- (void)sendPwdToHost {
    
    WCLog(@"开始授权");
    NSString *pwd = [WCUserInfo sharedWCUserInfo].pwd;
    
    NSError *error = nil;
    [_xmppStream authenticateWithPassword:pwd error:&error];
    if (error) {
        WCLog(@"%@", error);
    }
}

#pragma mark 授权成功后，发送`在线`消息
- (void)sendOnlineToHost {
    
    WCLog(@"发送`在线`消息");
    
    XMPPPresence *presence = [XMPPPresence presence];
    [_xmppStream sendElement:presence];
    
    WCLog(@"%@", presence);
}

#pragma mark - XMPPStreamDelegate 方法
#pragma mark 连接服务器成功
- (void)xmppStreamDidConnect:(XMPPStream *)sender {
    
    WCLog(@"连接服务器成功");
    [self sendPwdToHost];                                   // 登录
}

#pragma mark 与服务器断开连接
- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error {
    
    WCLog(@"与服务器断开连接--%@", error);
    
    if (_resultBlock && error) {
        _resultBlock(XMPPResultTypeNetError);
    }
}

#pragma mark 授权成功
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender {
    
    WCLog(@"授权成功");
    if (_resultBlock) {
        _resultBlock(XMPPResultTypeLoginSuccess);
    }
    
    // 发送`在线`消息
    [self sendOnlineToHost];
}

#pragma mark 授权失败
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error {
    
//    [_xmppStream disconnect];
    
    WCLog(@"授权失败--%@", error);
    if (_resultBlock) {
        _resultBlock(XMPPResultTypeLoginFailure);
    }
}

#pragma mark 发送`在线`消息失败
- (void)xmppStream:(XMPPStream *)sender didFailToSendPresence:(XMPPPresence *)presence error:(NSError *)error {
    
    WCLog(@"发送`在线`消息失败");
}

#pragma mark 登录
- (void)xmppLogin:(XMPPResultBlock)resultBlock {
    
    _resultBlock = resultBlock;
    
    [_xmppStream disconnect];
    
    [self connectToHost];
}

#pragma mark 注销
- (void)xmppLogout {
    
    XMPPPresence *lineOut = [XMPPPresence presenceWithType:@"unavailable"];
    [_xmppStream sendElement:lineOut];
    
    [_xmppStream disconnect];
    
    [[WCUserInfo sharedWCUserInfo] setLogined:NO];
    [[WCUserInfo sharedWCUserInfo] saveUserInfoToSandbox];
}
#pragma mark 收到消息
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message{
    self.receiveMessage = [XMPPMessage messageFromElement:message];
}

- (void)dealloc {
    
    [self teardownXMPPStream];
}

@end
