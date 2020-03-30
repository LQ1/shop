//
//  JSWebViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "JSWebViewController.h"

#import <JavaScriptCore/JavaScriptCore.h>

#import "JavaScriptInterface.h"

@interface JSWebViewController ()

@property (nonatomic,strong) JSContext *jsContext;

@end


@implementation JSWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// web开始加载
- (void)requestUrl
{
    // 加载
    self.webView.hidden = YES;
    [self.view DLLoadingInSelf];
    // 网络判断
    if ([NetStatusHelper sharedInstance].netStatus == NoneNet) {
        @weakify(self);
        [self.view DLLoadingCycleInSelf:^{
            @strongify(self);
            [self requestUrl];
        } code:DLDataFailed title:NO_NET_STATIC_SHOW buttonTitle:LOAD_FAILED_RETRY];
        return;
    }
    //开始加载
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlString]
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:10];
    [request setValue:@"1" forHTTPHeaderField:@"ISINLAZYSHOP"];
    [self.webView loadRequest:request];
}

// webView加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [super webViewDidFinishLoad:webView];
    // 获取js上下文
    self.jsContext = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    // 设置js桥接
    self.jsContext[NSStringFromClass([JavaScriptInterface class])] = [JavaScriptInterface sharedInstance];
    // 打印js异常
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        CLog(@"异常信息：%@", exceptionValue);
    };
}

- (void)dealloc
{
    self.webView.delegate = nil;
    [self stopWebLoading];
    // 取消js桥接
    self.jsContext[NSStringFromClass([JavaScriptInterface class])] = nil;
    self.jsContext = nil;
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
