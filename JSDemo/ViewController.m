//
//  ViewController.m
//  JSDemo
//
//  Created by 张晗 on 2016/10/14.
//  Copyright © 2016年 kuangxiang. All rights reserved.
//

#import "ViewController.h"
#import "JSWebViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemTap:)];
    
}

//http://novel-web-test.hbooker.com/test.html
- (void)rightBarButtonItemTap:(id)sender {
    JSWebViewController *jsVC = [[JSWebViewController alloc] init];
    [jsVC loadURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    [self.navigationController pushViewController:jsVC animated:YES];
}

@end
