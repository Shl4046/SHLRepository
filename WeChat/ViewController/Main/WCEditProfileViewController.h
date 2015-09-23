//
//  WCEditProfileViewController.h
//  WeChat
//
//  Created by 宋红亮 on 15/8/25.
//  Copyright © 2015年 Song. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WCEditProfileViewController;

@protocol WCEditProfileViewControllerDelegate <NSObject>

@optional

- (void)editProfileViewControllerDidSaved:(WCEditProfileViewController *)editProfileVc;

@end

@interface WCEditProfileViewController : WCTableViewController

@property (nonatomic, strong) UITableViewCell *cell;

@property (nonatomic, weak) id<WCEditProfileViewControllerDelegate> delegate;

@end
