//
//  ViewController.m
//  CloseWKGesture
//
//  Created by kong on 16/12/6.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import <objc/runtime.h>
#define KWidth [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<WKNavigationDelegate>
{
    WKWebView *_webView;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI
{
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    _webView.allowsBackForwardNavigationGestures = YES;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.aoyou.com"]]];
    _webView.navigationDelegate = self;
    
    id arr = [_webView valueForKey:@"gestureRecognizers"];
    if([arr isKindOfClass:[NSArray class]])
    {
        id gesture = arr[1];
        if ([gesture isKindOfClass:[UIScreenEdgePanGestureRecognizer class]])
        {
            UIScreenEdgePanGestureRecognizer *pan = (UIScreenEdgePanGestureRecognizer *)gesture;
            pan.enabled = NO;
        }
    }
    [self.view addSubview:_webView];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSString *urlString = navigationAction.request.URL.absoluteString.lowercaseString;

    
    if ([urlString containsString:@"aoyou.com"])
    {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    else
    {
        decisionHandler(WKNavigationActionPolicyCancel);
    }

}





@end
