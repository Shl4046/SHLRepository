//
//  WCLoginViewController.m
//  WeChat
//
//  Created by 宋红亮 on 15/8/17.
//  Copyright © 2015年 Song. All rights reserved.
//

#import "WCLoginViewController.h"
#import "WCNavigationController.h"
#import "AppDelegate.h"

@interface WCLoginViewController () <UITextFieldDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIView *midBgView;
@property (weak, nonatomic) IBOutlet UITextField *userLabel;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@end

@implementation WCLoginViewController

- (void)dealloc {
    
    if (SCREEN_4) {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [WCUserInfo sharedWCUserInfo].user = @"zhangsan";
  
    self.userLabel.text = [WCUserInfo sharedWCUserInfo].user;
    
    [self.loginBtn setBackgroundImage:[UIImage stretchedImageWithName:@"GreenBigBtn"]
                             forState:UIControlStateNormal];
    [self.loginBtn setBackgroundImage:[UIImage stretchedImageWithName:@"GreenBigBtnHighlight"]
                             forState:UIControlStateHighlighted];
    [self.loginBtn setBackgroundImage:[UIImage stretchedImageWithName:@"GreenBigBtnDisable"]
                             forState:UIControlStateDisabled];
    [self.registerBtn setBackgroundImage:[UIImage stretchedImageWithName:@"operationbox_text"]
                                forState:UIControlStateNormal];
    
    if (SCREEN_3_5) {
        
        self.topConstraint.constant = 60.0f;
    }
    
    if (SCREEN_4) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(kbFrmWillChanged:)
                                                     name:UIKeyboardWillChangeFrameNotification
                                                   object:self.pwdField];
    }
}

- (IBAction)fieldChanged {
    
    self.loginBtn.enabled = self.pwdField.text.length > 0;
}

- (void)kbFrmWillChanged:(NSNotification *)not {
    
    CGFloat windowH = [UIScreen mainScreen].bounds.size.height;
    CGRect kbEndFrm = [not.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat kbEndY = kbEndFrm.origin.y;
    
    [UIView animateWithDuration:[not.userInfo[UIKeyboardAnimationCurveUserInfoKey] floatValue]
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         if (kbEndY != windowH) {
                             self.midBgView.transform = CGAffineTransformMakeTranslation(0, -90.0f);
                         } else {
                             self.midBgView.transform = CGAffineTransformIdentity;
                         }
                         
                     } completion:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self userLogin];
    
    return YES;
}

#pragma mark - UIActionSheetDelegate 方法

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
}

#pragma mark - 用户登录

- (IBAction)userLogin {

    [self.view endEditing:YES];
    
    WCUserInfo *userInfo = [WCUserInfo sharedWCUserInfo];
    userInfo.user = self.userLabel.text;
    userInfo.pwd = self.pwdField.text;
    
    [super login];
}
- (IBAction)registerNewUser:(id)sender {
    [self enterMainPage];
}

@end
