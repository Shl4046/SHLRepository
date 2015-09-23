//
//  WCUserInfo.m
//  WeChat
//
//  Created by 宋红亮 on 15/8/20.
//  Copyright © 2015年 Song. All rights reserved.
//

#import "WCUserInfo.h"

#define UserKey @"user"
#define PwdKey @"pwd"
#define LoginedKey @"logined"

@implementation WCUserInfo

singleton_implementation(WCUserInfo)

- (void)saveUserInfoToSandbox {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.user forKey:UserKey];
    [defaults setObject:self.pwd forKey:PwdKey];
    [defaults setBool:self.isLogined forKey:LoginedKey];
    [defaults synchronize];
}

- (void)loadUserInfoToSandbox {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.user = [defaults objectForKey:UserKey];
    self.pwd = [defaults objectForKey:PwdKey];
    self.logined = [defaults boolForKey:LoginedKey];
}

- (NSString *)JID {
    
    return [NSString stringWithFormat:@"%@@%@", self.user, HOST_NAME];
}

@end
