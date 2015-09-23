//
//  WCContactCell.m
//  WeChat
//
//  Created by 宋红亮 on 15/8/29.
//  Copyright © 2015年 Song. All rights reserved.
//

#import "WCContactCell.h"

@interface WCContactCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation WCContactCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {}

- (void)setFrd:(XMPPUserCoreDataStorageObject *)frd {
    
    _frd = frd;
    
    if (frd.photo) {
        
        self.iconView.image = frd.photo;
    }else{
        self.iconView.image = [UIImage imageNamed:@"123.jpg"];
    }
    NSRange myrange = [frd.jidStr rangeOfString:@"@"];
    self.nicknameLabel.text = [frd.jidStr substringToIndex:myrange.location];
    
    /*sectionNum判断presence*/
    switch ([frd.sectionNum intValue]) {
        case 0:
            self.statusLabel.text = @"[在线]";
            break;
        case 1:
            self.statusLabel.text = @"[离开]";
            break;
        case 2:
            self.statusLabel.text = @"[离线]";
            break;
        default:
            break;
    }
}

@end
