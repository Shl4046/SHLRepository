//
//  WCMessageCellTableViewCell.m
//  WeChat
//
//  Created by 宋红亮 on 15/9/16.
//  Copyright © 2015年 Song. All rights reserved.
//

#import "WCMessageCell.h"
@interface WCMessageCell ()

@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageBody;


@end
@implementation WCMessageCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {}

- (void)setMessagedata:(XMPPMessageArchiving_Message_CoreDataObject *)messagedata {
    _messagedata  = messagedata;
    _messageBody.text =  _messagedata.body;
    NSRange myrange = [_messagedata.bareJidStr rangeOfString:@"@"];
    _nicknameLabel.text = [_messagedata.bareJidStr substringToIndex:myrange.location];
}

@end
