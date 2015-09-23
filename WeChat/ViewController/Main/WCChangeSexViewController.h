//
//  WCChangeSexViewController.h
//  WeChat
//
//  Created by 宋红亮 on 15/8/27.
//  Copyright © 2015年 Song. All rights reserved.
//

#import "WCTableViewController.h"

@class WCChangeSexViewController;

@protocol WCChangeSexViewControllerDelegate <NSObject>

@optional

- (void)changeSexViewController:(WCChangeSexViewController *)chanegeSexVc didSelectedAtIndex:(int)index;

@end

@interface WCChangeSexViewController : WCTableViewController

@property (nonatomic, strong) UITableViewCell *cell;

@property (nonatomic, weak) id<WCChangeSexViewControllerDelegate> delegate;

@end
