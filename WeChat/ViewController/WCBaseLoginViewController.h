//
//  WCBaseLoginViewController.h
//  WeChat
//
//  Created by 宋红亮 on 15/8/20.
//  Copyright © 2015年 Song. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCBaseLoginViewController : UIViewController

/** 登录 供子类调用 */
- (void)login;
-(void)enterMainPage;
@end
