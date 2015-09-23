//
//  ShopViewController.m
//  WeChat
//
//  Created by 宋红亮 on 15/9/22.
//  Copyright © 2015年 Song. All rights reserved.
//

#import "WCShopViewController.h"

@interface WCShopViewController ()

@end

@implementation WCShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL* url = [NSURL URLWithString:@"http://www.jd.com"];
    [self.shopWebView loadRequest:[NSURLRequest requestWithURL:url]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
