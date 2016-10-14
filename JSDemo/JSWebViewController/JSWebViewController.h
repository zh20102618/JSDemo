//
//  JSWebViewController.h
//  JSDemo
//
//  Created by 张晗 on 2016/10/14.
//  Copyright © 2016年 kuangxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSWebViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic, strong, readonly) UIWebView *webView;

- (void)loadURL:(NSURL *)URL;

@end
