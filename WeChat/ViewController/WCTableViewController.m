//
//  WCTableViewController.m
//  WeChat
//
//  Created by 宋红亮 on 15/8/26.
//  Copyright © 2015年 Song. All rights reserved.
//

#import "WCTableViewController.h"

@interface WCTableViewController ()

@end

@implementation WCTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *header = [[UIView alloc] init];
    header.frame = CGRectMake(0, 0, 1.0f, 20.0f);
    header.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = header;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [cell layoutSubviews];
}

@end
