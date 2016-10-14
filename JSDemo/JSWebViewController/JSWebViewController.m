//
//  JSWebViewController.m
//  JSDemo
//
//  Created by 张晗 on 2016/10/14.
//  Copyright © 2016年 kuangxiang. All rights reserved.
//

#import "JSWebViewController.h"
#import "WebViewJavascriptBridge.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface JSWebViewController ()<NJKWebViewProgressDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NJKWebViewProgressView *progressView;
@property (nonatomic, strong) NJKWebViewProgress *webViewProxy;
@property (nonatomic, strong) WebViewJavascriptBridge *bridge;

@end

@implementation JSWebViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar addSubview:self.progressView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.progressView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    self.navigationItem.leftItemsSupplementBackButton = YES;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reload:)];
    
    self.webViewProxy = [[NJKWebViewProgress alloc] init];
    self.webViewProxy.progressDelegate = self;
    self.webViewProxy.webViewProxyDelegate = self;
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    [self.bridge setWebViewDelegate:self.webViewProxy];
    
    [self.bridge callHandler:@"getMessageFromApp" data:@"测试WebViewJavascriptBridge" responseCallback:^(id responseData) {
        NSLog(@"responseData = %@", responseData);
    }];
    [self.bridge registerHandler:@"sendMessageToApp" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"%@", data);
        if (responseCallback) {
            responseCallback(data);
        }
    }];
}

- (NJKWebViewProgressView *)progressView {
    if (!_progressView) {
        CGRect rect = self.navigationController.navigationBar.bounds;
        rect.origin.y = self.navigationController.navigationBar.frame.size.height - 2.0;
        rect.size.height = 2.0;
        _progressView = [[NJKWebViewProgressView alloc] initWithFrame:rect];
        _progressView.progress = 0;
        _progressView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
    }
    return _progressView;
}

- (void)loadURL:(NSURL *)URL {
    [self.webView loadRequest:[NSURLRequest requestWithURL:URL]];
}

- (void)back:(id)sender {
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }
}

- (void)reload:(id)sender {
    [self.webView reload];
}

#pragma mark - NJKWebViewProgressDelegate
- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress {
    [self.progressView setProgress:progress animated:YES];
    self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"URL = %@", request.URL.absoluteString);
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}

@end
