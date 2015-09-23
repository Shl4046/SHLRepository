//
//  WCUserInfo.h
//  WeChat
//
//  Created by 宋红亮 on 15/8/20.
//  Copyright © 2015年 Song. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface WCUserInfo : NSObject

/** 账号 */
@property (nonatomic, copy) NSString *user;
/** 密码 */
@property (nonatomic, copy) NSString *pwd;
/** 是否已登录 */
@property (nonatomic, assign, getter=isLogined) BOOL logined;
@property (nonatomic, copy) NSString *JID;
@property (nonatomic, copy) NSString *registerUser;
@property (nonatomic, copy) NSString *registerPwd;

singleton_interface(WCUserInfo)

- (void)saveUserInfoToSandbox;

- (void)loadUserInfoToSandbox;

@end
