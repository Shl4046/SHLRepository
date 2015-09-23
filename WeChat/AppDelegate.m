//
//  AppDelegate.m
//  WeChat
//
//  Created by 宋红亮 on 15/8/17.
//  Copyright © 2015年 Song. All rights reserved.
//

#import "AppDelegate.h"
#import "WCNavigationController.h"
#import "DDLog.h"
#import "DDTTYLogger.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

/** iPhone禁止旋转 iPad允许旋转 */
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    
    if (!IPAD) {
        return UIInterfaceOrientationMaskPortrait;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // XMPP的log
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    [WCNavigationController setupNavTheme];
    
    // 从沙盒加载用户信息单例
    [[WCUserInfo sharedWCUserInfo] loadUserInfoToSandbox];
    
    if ([WCUserInfo sharedWCUserInfo].isLogined) {
        
        UIStoryboard *login = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.window.rootViewController = login.instantiateInitialViewController;
        [[WCXMPPTool sharedWCXMPPTool] xmppLogin:nil];
    }
    
    return YES;
}

@end