//
//  WCChangeSexViewController.m
//  WeChat
//
//  Created by 宋红亮 on 15/8/27.
//  Copyright © 2015年 Song. All rights reserved.
//

#import "WCChangeSexViewController.h"

@interface WCChangeSexViewController ()
@property (weak, nonatomic) IBOutlet WCTableViewCell *maleCell;
@property (weak, nonatomic) IBOutlet WCTableViewCell *femaleCell;

@end

@implementation WCChangeSexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 标题 内容
    self.title = self.cell.textLabel.text;
    
    if ([self.cell.detailTextLabel.text isEqualToString:@"男"]) {
        
        self.maleCell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.femaleCell.accessoryType = UITableViewCellAccessoryNone;
        
    } else if ([self.cell.detailTextLabel.text isEqualToString:@"女"]) {
        
        self.maleCell.accessoryType = UITableViewCellAccessoryNone;
        self.femaleCell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        self.cell.detailTextLabel.text = @"男";
        
    } else if (indexPath.row == 1) {
        
        self.cell.detailTextLabel.text = @"女";
    }
    
    if ([self.delegate respondsToSelector:@selector(changeSexViewController:didSelectedAtIndex:)]) {
        [self.delegate changeSexViewController:self didSelectedAtIndex:indexPath.row];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
